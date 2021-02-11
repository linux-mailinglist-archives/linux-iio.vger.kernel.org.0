Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0F318BCC
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBKNRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 08:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhBKNPS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 08:15:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97346C061756;
        Thu, 11 Feb 2021 05:14:36 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q9so5012200ilo.1;
        Thu, 11 Feb 2021 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaWT11VKWyn2uORRCibZSFi/qJOW4Eg9p6rFjiWryHA=;
        b=O391STiNhG3s/WRQht8rugL07cj8J77PPw31l2435034KWJvxWD9nsnVWNItVNNxWe
         d5g4bRGlKgRc7TVVNp4PUZ9Q5xiqMynVQYty3wFTnS/MOHysEyB4UQslMq0kUHOEKVJr
         AK8jNsTZB34S61qHeQh8MR0gwzqmVrf8je9LQo1IZkHGiSp7DHsL3AZ1+ddjp4N/mjKq
         0wqdmO9ZHr+RiA0SMgKHIfrwAHc+87BskEiBPBGMnllZ2GGpPzKjw1lFaHAZGrAuJsWH
         KeVrpdN6Vbfv30vhUaPb/h8xMw2MZ7F48QdMDE5qOe468KymQbgg9Pln3IJF8B6Hl6gU
         uFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaWT11VKWyn2uORRCibZSFi/qJOW4Eg9p6rFjiWryHA=;
        b=QcpgSA3Rhas23tKi9RnCpe8LXzgiIfV8VgQpaKCx6Tn8XD+jhNfzH5/DFtWP107IjK
         GAHrPK3fvOyCobRAhFVMzCfWEdcyf/2HhHDKR5kfvYck3MrHwcWK/J3yJJKseEAAHucz
         DdqegrYNHX7jUpNGgxJ03D7Wg7BLxTX5Fba6e7HSPRxZ6gjxtUT5dePVXyNt+8kynS6Q
         /GnToT6ectVNIrPJ1HbgBoX3LNaC+IpaM0VGbr6Zr1LPjEH8qmC1dwqWPk4+yBqJ20JY
         g1EIWma5eFStcalsb+xqrprAMi3TbcPcAby0jALMU/ZFRwe2DmpFMwIo58ZWPAX+ZWzy
         uuzQ==
X-Gm-Message-State: AOAM5311wV2IF91y+3SHj854a6K/pjuX1jbBJiavL7j0fsiTRb6jmZNO
        oFQY0C5Fn0097SjeALztDTiK2is667rv+GXYqYQ=
X-Google-Smtp-Source: ABdhPJzkfNqlGQjHMubNaQg1+u/L5l/ZyU+t/fc5z3CN7u2JModVJN9BwjfvAFAl7He5OG+eH6pj0JqzvTmmOmAVqbk=
X-Received: by 2002:a05:6e02:1be1:: with SMTP id y1mr5487782ilv.101.1613049275631;
 Thu, 11 Feb 2021 05:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20210211123353.78963-1-alexandru.ardelean@analog.com> <20210211123353.78963-4-alexandru.ardelean@analog.com>
In-Reply-To: <20210211123353.78963-4-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 11 Feb 2021 15:14:23 +0200
Message-ID: <CA+U=DsqtURTGzG-h0Avrk=cMbjObB-0Lwt68P7wkrK0aj7ueOg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: iio: add example for high-speed buffer support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 11, 2021 at 2:38 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> Following a recent update to the IIO buffer infrastructure, this change
> adds a basic example on how to access an IIO buffer via the new mmap()
> interface.
>
> The ioctl() for the high-speed mode needs to be enabled right from the
> start, before setting any parameters via sysfs (length, enable, etc), to
> make sure that the mmap mode is used and not the fileio mode.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  tools/iio/iio_generic_buffer.c | 184 +++++++++++++++++++++++++++++++--
>  1 file changed, 178 insertions(+), 6 deletions(-)
>
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index fdd08514d556..af1a944edcdb 100644
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
>         return 0;
>  }
>
> +struct mmap_block {
> +       struct iio_buffer_block block;
> +       void *addr;
> +};
> +
> +static struct mmap_block *enable_high_speed(int buf_fd, unsigned int block_size,
> +                                           int nblocks)
> +{
> +       struct iio_buffer_block_alloc_req req = { 0 };
> +       struct mmap_block *mmaps = NULL;
> +       int mmaps_cnt = 0;
> +       int i, ret;
> +
> +       /**
> +        * Validate we can do high-speed by issuing BLOCK_FREE ioctl.
> +        * If using just BLOCK_ALLOC it's distinguish between ENOSYS
> +        * and other error types.
> +        */
> +       ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
> +       if (ret < 0) {
> +               errno = ENOSYS;
> +               return NULL;
> +       }
> +
> +       /* for now, this */
> +       req.id = 0;
> +       req.type = 0;
> +       req.size = block_size;
> +       req.count = nblocks;
> +
> +       ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ALLOC_IOCTL, &req);
> +       if (ret < 0)
> +               return NULL;
> +
> +       if (req.count == 0) {
> +               errno = ENOMEM;
> +               return NULL;
> +       }
> +
> +       if (req.count < nblocks) {
> +               fprintf(stderr, "Requested %d blocks, got %d\n",
> +                       nblocks, req.count);
> +               errno = ENOMEM;
> +               return NULL;
> +       }
> +
> +       mmaps = calloc(req.count, sizeof(*mmaps));
> +       if (!mmaps) {
> +               errno = ENOMEM;
> +               return NULL;
> +       }
> +
> +       for (i = 0; i < req.count; i++) {
> +               mmaps[i].block.id = i;
> +               ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_QUERY_IOCTL, &mmaps[i].block);
> +               if (ret < 0)
> +                       goto error;
> +
> +               ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[i].block);
> +               if (ret < 0)
> +                       goto error;
> +
> +               mmaps[i].addr = mmap(0, mmaps[i].block.size,
> +                                     PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                     buf_fd, mmaps[i].block.data.offset);
> +
> +               if (mmaps[i].addr == MAP_FAILED)
> +                       goto error;
> +
> +               mmaps_cnt++;
> +       }
> +
> +       return mmaps;
> +
> +error:
> +       for (i = 0; i < mmaps_cnt; i++)
> +               munmap(mmaps[i].addr, mmaps[i].block.size);
> +       free(mmaps);
> +       return NULL;
> +}
> +
> +static int read_high_speed(int buf_fd, char *data, unsigned int block_size,
> +                          struct mmap_block *mmaps, unsigned int mmaps_cnt)
> +{
> +       struct iio_buffer_block block;
> +       int ret;
> +
> +       /**
> +        * This is where some buffer-pool management can do wonders,
> +        * but for the sake of this sample-code, we're just going to
> +        * copy the data and re-enqueue it back
> +        */
> +       memset(&block, 0, sizeof(block));
> +       ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_DEQUEUE_IOCTL, &block);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* check for weird conditions */
> +       if (block.bytes_used > block_size) {
> +               fprintf(stderr,
> +                       "Got a bigger block (%u) than expected (%u)\n",
> +                       block.bytes_used, block_size);
> +               return -EFBIG;
> +       }
> +
> +       if (block.bytes_used < block_size) {
> +               /**
> +                * This can be normal, with some real-world data
> +                * terminating abruptly. But log it.
> +                */
> +               fprintf(stderr,
> +                       "Got a smaller block (%u) than expected (%u)\n",
> +                       block.bytes_used, block_size);
> +       }
> +
> +       /* memcpy() the data, we lose some more performance here :p */
> +       memcpy(data, mmaps[block.id].addr, block.bytes_used);
> +
> +       /* and re-queue this back */
> +       ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[block.id].block);
> +       if (ret < 0)
> +               return ret;
> +
> +       return block.bytes_used;
> +}
> +

forgot to remove this extra line;
will make a note, for the next re-spin;
after some feedback

> +
>  static void print_usage(void)
>  {
>         fprintf(stderr, "Usage: generic_buffer [options]...\n"
> @@ -249,6 +377,7 @@ static void print_usage(void)
>                 "  -c <n>     Do n conversions, or loop forever if n < 0\n"
>                 "  -e         Disable wait for event (new data)\n"
>                 "  -g         Use trigger-less mode\n"
> +               "  -h         Use high-speed buffer access\n"
>                 "  -l <n>     Set buffer length to n samples\n"
>                 "  --device-name -n <name>\n"
>                 "  --device-num -N <num>\n"
> @@ -356,9 +485,15 @@ int main(int argc, char **argv)
>
>         struct iio_channel_info *channels = NULL;
>
> +       static bool use_high_speed = false;
> +       unsigned int block_size;
> +       int nblocks = 16; /* default */
> +       int mmaps_cnt = 0;
> +       struct mmap_block *mmaps = NULL;
> +
>         register_cleanup();
>
> -       while ((c = getopt_long(argc, argv, "aAb:c:egl:n:N:t:T:w:?", longopts,
> +       while ((c = getopt_long(argc, argv, "aAb:c:eghl:n:N:t:T:w:?", longopts,
>                                 NULL)) != -1) {
>                 switch (c) {
>                 case 'a':
> @@ -396,6 +531,9 @@ int main(int argc, char **argv)
>                 case 'g':
>                         notrigger = 1;
>                         break;
> +               case 'h':
> +                       use_high_speed = true;
> +                       break;
>                 case 'l':
>                         errno = 0;
>                         buf_len = strtoul(optarg, &dummy, 10);
> @@ -661,6 +799,29 @@ int main(int argc, char **argv)
>                 goto error;
>         }
>
> +       scan_size = size_from_channelarray(channels, num_channels);
> +       block_size = scan_size * buf_len;
> +       /**
> +        * Need to enable high-speed before configuring length/enable.
> +        * Otherwise, the DMA buffer will work in fileio mode,
> +        * and mmap won't work.
> +        */
> +       if (use_high_speed) {
> +               /**
> +                * The block_size for one block is the same as 'data', but it
> +                * doesn't need to be the same size. It is easier for the sake
> +                * of this example.
> +                */
> +               mmaps = enable_high_speed(buf_fd, block_size, nblocks);
> +               if (!mmaps) {
> +                       fprintf(stderr, "Could not enable high-speed mode\n");
> +                       ret = -errno;
> +                       goto error;
> +               }
> +               mmaps_cnt = nblocks;
> +               printf("Using high-speed mode\n");
> +       }
> +
>         /* Setup ring buffer parameters */
>         ret = write_sysfs_int("length", buf_dir_name, buf_len);
>         if (ret < 0)
> @@ -675,8 +836,7 @@ int main(int argc, char **argv)
>                 goto error;
>         }
>
> -       scan_size = size_from_channelarray(channels, num_channels);
> -       data = malloc(scan_size * buf_len);
> +       data = malloc(block_size);
>         if (!data) {
>                 ret = -ENOMEM;
>                 goto error;
> @@ -719,7 +879,13 @@ int main(int argc, char **argv)
>                         toread = 64;
>                 }
>
> -               read_size = read(buf_fd, data, toread * scan_size);
> +               if (use_high_speed) {
> +                       read_size = read_high_speed(buf_fd, data, block_size,
> +                                                   mmaps, mmaps_cnt);
> +               } else {
> +                       read_size = read(buf_fd, data, toread * scan_size);
> +               }
> +
>                 if (read_size < 0) {
>                         if (errno == EAGAIN) {
>                                 fprintf(stderr, "nothing available\n");
> @@ -738,8 +904,14 @@ int main(int argc, char **argv)
>
>         if (fd >= 0 && close(fd) == -1)
>                 perror("Failed to close character device");
> -       if (buf_fd >= 0 && close(buf_fd) == -1)
> -               perror("Failed to close buffer");
> +       for (i = 0; i < mmaps_cnt; i++)
> +               munmap(mmaps[i].addr, mmaps[i].block.size);
> +       free(mmaps);
> +       if (buf_fd >= 0) {
> +               ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
> +               if (close(buf_fd) == -1)
> +                       perror("Failed to close buffer");
> +       }
>         free(buffer_access);
>         free(data);
>         free(buf_dir_name);
> --
> 2.17.1
>
