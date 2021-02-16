Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4CB31D122
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 20:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBPTqC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 14:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhBPTqB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Feb 2021 14:46:01 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D2664D7F;
        Tue, 16 Feb 2021 19:45:19 +0000 (UTC)
Date:   Tue, 16 Feb 2021 19:45:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v3 5/5] tools: iio: add example for high-speed buffer
 support
Message-ID: <20210216194511.459598a3@archlinux>
In-Reply-To: <20210215143234.3248-6-alexandru.ardelean@analog.com>
References: <20210215143234.3248-1-alexandru.ardelean@analog.com>
        <20210215143234.3248-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 16:32:34 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Following a recent update to the IIO buffer infrastructure, this change
> adds a basic example on how to access an IIO buffer via the new mmap()
> interface.
> 
> The ioctl() for the high-speed mode needs to be enabled right from the
> start, before setting any parameters via sysfs (length, enable, etc), to
> make sure that the mmap mode is used and not the fileio mode.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alex,

One comment right at the end but I don't think we need to change it.

Jonathan

> ---
>  tools/iio/iio_generic_buffer.c | 184 +++++++++++++++++++++++++++++++--
>  1 file changed, 178 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 2491c54a5e4f..99dcc3b339b1 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -31,6 +31,7 @@
>  #include <stdbool.h>
>  #include <signal.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>  #include <linux/iio/buffer.h>
>  #include "iio_utils.h"
>  
> @@ -239,6 +240,133 @@ static int enable_disable_all_channels(char *dev_dir_name, int buffer_idx, int e
>  	return 0;
>  }
>  
> +struct mmap_block {
> +	struct iio_buffer_block block;
> +	void *addr;
> +};
> +
> +static struct mmap_block *enable_high_speed(int buf_fd, unsigned int block_size,
> +					    int nblocks)
> +{
> +	struct iio_buffer_block_alloc_req req = { 0 };
> +	struct mmap_block *mmaps = NULL;
> +	int mmaps_cnt = 0;
> +	int i, ret;
> +
> +	/**
> +	 * Validate we can do high-speed by issuing BLOCK_FREE ioctl.
> +	 * If using just BLOCK_ALLOC it's distinguish between ENOSYS
> +	 * and other error types.
> +	 */
> +	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
> +	if (ret < 0) {
> +		errno = ENOSYS;
> +		return NULL;
> +	}
> +
> +	/* for now, this */
> +	req.id = 0;
> +	req.type = 0;
> +	req.size = block_size;
> +	req.count = nblocks;
> +
> +	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ALLOC_IOCTL, &req);
> +	if (ret < 0)
> +		return NULL;
> +
> +	if (req.count == 0) {
> +		errno = ENOMEM;
> +		return NULL;
> +	}
> +
> +	if (req.count < nblocks) {
> +		fprintf(stderr, "Requested %d blocks, got %d\n",
> +			nblocks, req.count);
> +		errno = ENOMEM;
> +		return NULL;
> +	}
> +
> +	mmaps = calloc(req.count, sizeof(*mmaps));
> +	if (!mmaps) {
> +		errno = ENOMEM;
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < req.count; i++) {
> +		mmaps[i].block.id = i;
> +		ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_QUERY_IOCTL, &mmaps[i].block);
> +		if (ret < 0)
> +			goto error;
> +
> +		ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[i].block);
> +		if (ret < 0)
> +			goto error;
> +
> +		mmaps[i].addr = mmap(0, mmaps[i].block.size,
> +				      PROT_READ | PROT_WRITE, MAP_SHARED,
> +				      buf_fd, mmaps[i].block.data.offset);
> +
> +		if (mmaps[i].addr == MAP_FAILED)
> +			goto error;
> +
> +		mmaps_cnt++;
> +	}
> +
> +	return mmaps;
> +
> +error:
> +	for (i = 0; i < mmaps_cnt; i++)
> +		munmap(mmaps[i].addr, mmaps[i].block.size);
> +	free(mmaps);
> +	ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
> +	return NULL;
> +}
> +
> +static int read_high_speed(int buf_fd, char *data, unsigned int block_size,
> +			   struct mmap_block *mmaps, unsigned int mmaps_cnt)
> +{
> +	struct iio_buffer_block block;
> +	int ret;
> +
> +	/**
> +	 * This is where some buffer-pool management can do wonders,
> +	 * but for the sake of this sample-code, we're just going to
> +	 * copy the data and re-enqueue it back
> +	 */
> +	memset(&block, 0, sizeof(block));
> +	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_DEQUEUE_IOCTL, &block);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* check for weird conditions */
> +	if (block.bytes_used > block_size) {
> +		fprintf(stderr,
> +			"Got a bigger block (%u) than expected (%u)\n",
> +			block.bytes_used, block_size);
> +		return -EFBIG;
> +	}
> +
> +	if (block.bytes_used < block_size) {
> +		/**
> +		 * This can be normal, with some real-world data
> +		 * terminating abruptly. But log it.
> +		 */
> +		fprintf(stderr,
> +			"Got a smaller block (%u) than expected (%u)\n",
> +			block.bytes_used, block_size);
> +	}
> +
> +	/* memcpy() the data, we lose some more performance here :p */
> +	memcpy(data, mmaps[block.id].addr, block.bytes_used);
> +
> +	/* and re-queue this back */
> +	ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[block.id].block);
> +	if (ret < 0)
> +		return ret;
> +
> +	return block.bytes_used;
> +}
> +
>  static void print_usage(void)
>  {
>  	fprintf(stderr, "Usage: generic_buffer [options]...\n"
> @@ -249,6 +377,7 @@ static void print_usage(void)
>  		"  -c <n>     Do n conversions, or loop forever if n < 0\n"
>  		"  -e         Disable wait for event (new data)\n"
>  		"  -g         Use trigger-less mode\n"
> +		"  -h         Use high-speed buffer access\n"
>  		"  -l <n>     Set buffer length to n samples\n"
>  		"  --device-name -n <name>\n"
>  		"  --device-num -N <num>\n"
> @@ -356,9 +485,15 @@ int main(int argc, char **argv)
>  
>  	struct iio_channel_info *channels = NULL;
>  
> +	static bool use_high_speed = false;
> +	unsigned int block_size;
> +	int nblocks = 16; /* default */
> +	int mmaps_cnt = 0;
> +	struct mmap_block *mmaps = NULL;
> +
>  	register_cleanup();
>  
> -	while ((c = getopt_long(argc, argv, "aAb:c:egl:n:N:t:T:w:?", longopts,
> +	while ((c = getopt_long(argc, argv, "aAb:c:eghl:n:N:t:T:w:?", longopts,
>  				NULL)) != -1) {
>  		switch (c) {
>  		case 'a':
> @@ -396,6 +531,9 @@ int main(int argc, char **argv)
>  		case 'g':
>  			notrigger = 1;
>  			break;
> +		case 'h':
> +			use_high_speed = true;
> +			break;
>  		case 'l':
>  			errno = 0;
>  			buf_len = strtoul(optarg, &dummy, 10);
> @@ -659,6 +797,29 @@ int main(int argc, char **argv)
>  		goto error;
>  	}
>  
> +	scan_size = size_from_channelarray(channels, num_channels);
> +	block_size = scan_size * buf_len;
> +	/**
> +	 * Need to enable high-speed before configuring length/enable.
> +	 * Otherwise, the DMA buffer will work in fileio mode,
> +	 * and mmap won't work.
> +	 */
> +	if (use_high_speed) {
> +		/**
> +		 * The block_size for one block is the same as 'data', but it
> +		 * doesn't need to be the same size. It is easier for the sake
> +		 * of this example.
> +		 */
> +		mmaps = enable_high_speed(buf_fd, block_size, nblocks);
> +		if (!mmaps) {
> +			fprintf(stderr, "Could not enable high-speed mode\n");
> +			ret = -errno;
> +			goto error;
> +		}
> +		mmaps_cnt = nblocks;
> +		printf("Using high-speed mode\n");
> +	}
> +
>  	/* Setup ring buffer parameters */
>  	ret = write_sysfs_int("length", buf_dir_name, buf_len);
>  	if (ret < 0)
> @@ -673,8 +834,7 @@ int main(int argc, char **argv)
>  		goto error;
>  	}
>  
> -	scan_size = size_from_channelarray(channels, num_channels);
> -	data = malloc(scan_size * buf_len);
> +	data = malloc(block_size);
>  	if (!data) {
>  		ret = -ENOMEM;
>  		goto error;
> @@ -721,7 +881,13 @@ int main(int argc, char **argv)
>  			toread = 64;
>  		}
>  
> -		read_size = read(buf_fd, data, toread * scan_size);
> +		if (use_high_speed) {
> +			read_size = read_high_speed(buf_fd, data, block_size,
> +						    mmaps, mmaps_cnt);
> +		} else {
> +			read_size = read(buf_fd, data, toread * scan_size);
> +		}
> +
>  		if (read_size < 0) {
>  			if (errno == EAGAIN) {
>  				fprintf(stderr, "nothing available\n");
> @@ -740,8 +906,14 @@ int main(int argc, char **argv)
>  
>  	if (fd >= 0 && close(fd) == -1)
>  		perror("Failed to close character device");
> -	if (buf_fd >= 0 && close(buf_fd) == -1)
> -		perror("Failed to close buffer");
> +	for (i = 0; i < mmaps_cnt; i++)
> +		munmap(mmaps[i].addr, mmaps[i].block.size);
> +	free(mmaps);
> +	if (buf_fd >= 0) {
> +		ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);

A little odd to call this in paths where we weren't using block
mode, but seems harmless.


> +		if (close(buf_fd) == -1)
> +			perror("Failed to close buffer");
> +	}
>  	free(buffer_access);
>  	free(data);
>  	free(buf_dir_name);

