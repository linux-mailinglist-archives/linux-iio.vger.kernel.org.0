Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A4431B82C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 12:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBOLkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhBOLkU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 06:40:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A42C061574;
        Mon, 15 Feb 2021 03:39:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s24so6433914iob.6;
        Mon, 15 Feb 2021 03:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyN4jV5GXUru7tvvnvfRnlqBrGsqGmb2kviBXtv4L1A=;
        b=EuCnbnvITADRhFXlX0FzMDWwHLQmYqqmqTHzTlPO7gjqQ60zs29iiDw3GQsBStYE+v
         /BnNwVNWzFDKmWnYH8jAY8obDEU5P2NYVmSkotgzoe0uBzRgevSR6njpa+9efb8m0n15
         h/tnXCw6IenQr/oA1ExCZpAfwRF7Cy76sikyzEXbR5zWak8VNXA+fhPcIaw8x+7oEJU4
         tRgcTQls+zsoQTe6NO/+vsSK3rPkwFBuMwEbWmatHAN9qJL1dB5/zCiTs0iNq+8TaFzF
         AEunJW7GVC8rsdw6RznA7n0chT7uEFd8sh5a+97MTviXZribjdzpR9sk2Mtwse2syuQ6
         kbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyN4jV5GXUru7tvvnvfRnlqBrGsqGmb2kviBXtv4L1A=;
        b=tK3z4SLUZSxGF/ms9UTwmrhkcjg2PWkrknwXxKZRAaCEUylxvJ5j9tPpYPpcRc6LX8
         LniMOoCCHbKlX+9Tej6sVw5whX0OA5KbIUzamVeMvS6qSmEdmIhp6NkPBblkm9wzB6AV
         2LasXgRk3U9pKbW8toeR2wu8Ah8hbZgKGBsBvjTdJlVSgZmRwzT3sWPxFI/gfo2JesUo
         Zh/ZSb0k9P/a9WFZfJ76o9thXqyqJfoPcwomAID5/kjSQakNvMv+awZpVl0HU9m/+9fp
         fC9/kMq9DXNhoNv8fZACOHA6cKl8It4rpx9Z0Yi+y56zzUNXo51mVJqftnELhc/lwMhC
         LHvQ==
X-Gm-Message-State: AOAM530WCA5gETup3jfbbZoFvXpt+b5zDbWlPjVPD7fdwLySQxdvXwAf
        JdQljlbxXal/Jm63kEUtawd9t1J/jWHm0+aLHPUUWFre
X-Google-Smtp-Source: ABdhPJzeDlrbjJFq33bOl353Sn4b1jPMBjL1JVT5VHKbKgXJxkfkihHNDlMVNni7PGHWipUFBciwxIbqgNgaOv8ISag=
X-Received: by 2002:a5e:8e09:: with SMTP id a9mr1004992ion.98.1613389179623;
 Mon, 15 Feb 2021 03:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20210212101143.18993-1-alexandru.ardelean@analog.com>
 <20210212101143.18993-4-alexandru.ardelean@analog.com> <20210214155628.0986a678@archlinux>
In-Reply-To: <20210214155628.0986a678@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Feb 2021 13:39:28 +0200
Message-ID: <CA+U=Dspbu-CY9HM5ZhmXXzJP4HpQaXdN1YA1Mv+cyL3g3gBw-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tools: iio: add example for high-speed buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 14, 2021 at 5:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 12 Feb 2021 12:11:43 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > Following a recent update to the IIO buffer infrastructure, this change
> > adds a basic example on how to access an IIO buffer via the new mmap()
> > interface.
> >
> > The ioctl() for the high-speed mode needs to be enabled right from the
> > start, before setting any parameters via sysfs (length, enable, etc), to
> > make sure that the mmap mode is used and not the fileio mode.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Just one small question on error handling. Otherwise this looks fine to me.
>
> thanks,
>
> Jonathan
>
> > ---
> >  tools/iio/iio_generic_buffer.c | 183 +++++++++++++++++++++++++++++++--
> >  1 file changed, 177 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> > index fdd08514d556..675a7e6047e0 100644
> > --- a/tools/iio/iio_generic_buffer.c
> > +++ b/tools/iio/iio_generic_buffer.c
> > @@ -31,6 +31,7 @@
> >  #include <stdbool.h>
> >  #include <signal.h>
> >  #include <sys/ioctl.h>
> > +#include <sys/mman.h>
> >  #include <linux/iio/buffer.h>
> >  #include "iio_utils.h"
> >
> > @@ -239,6 +240,132 @@ static int enable_disable_all_channels(char *dev_dir_name, int buffer_idx, int e
> >       return 0;
> >  }
> >
> > +struct mmap_block {
> > +     struct iio_buffer_block block;
> > +     void *addr;
> > +};
> > +
> > +static struct mmap_block *enable_high_speed(int buf_fd, unsigned int block_size,
> > +                                         int nblocks)
> > +{
> > +     struct iio_buffer_block_alloc_req req = { 0 };
> > +     struct mmap_block *mmaps = NULL;
> > +     int mmaps_cnt = 0;
> > +     int i, ret;
> > +
> > +     /**
> > +      * Validate we can do high-speed by issuing BLOCK_FREE ioctl.
> > +      * If using just BLOCK_ALLOC it's distinguish between ENOSYS
> > +      * and other error types.
> > +      */
> > +     ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
> > +     if (ret < 0) {
> > +             errno = ENOSYS;
> > +             return NULL;
> > +     }
> > +
> > +     /* for now, this */
> > +     req.id = 0;
> > +     req.type = 0;
> > +     req.size = block_size;
> > +     req.count = nblocks;
> > +
> > +     ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ALLOC_IOCTL, &req);
> > +     if (ret < 0)
> > +             return NULL;
> > +
> > +     if (req.count == 0) {
> > +             errno = ENOMEM;
> > +             return NULL;
> > +     }
> > +
> > +     if (req.count < nblocks) {
> > +             fprintf(stderr, "Requested %d blocks, got %d\n",
> > +                     nblocks, req.count);
> > +             errno = ENOMEM;
> > +             return NULL;
> > +     }
> > +
> > +     mmaps = calloc(req.count, sizeof(*mmaps));
> > +     if (!mmaps) {
> > +             errno = ENOMEM;
> > +             return NULL;
> > +     }
> > +
> > +     for (i = 0; i < req.count; i++) {
> > +             mmaps[i].block.id = i;
> > +             ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_QUERY_IOCTL, &mmaps[i].block);
> > +             if (ret < 0)
> > +                     goto error;
> > +
> > +             ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[i].block);
> > +             if (ret < 0)
> > +                     goto error;
>
> > +
> > +             mmaps[i].addr = mmap(0, mmaps[i].block.size,
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   buf_fd, mmaps[i].block.data.offset);
> > +
> > +             if (mmaps[i].addr == MAP_FAILED)
> > +                     goto error;
> > +
> > +             mmaps_cnt++;
> > +     }
> > +
> > +     return mmaps;
> > +
> > +error:
> > +     for (i = 0; i < mmaps_cnt; i++)
> > +             munmap(mmaps[i].addr, mmaps[i].block.size);
> > +     free(mmaps);
>
> No free of the blocks?  We have unmapped them but I'd imagine we'd also
> need to free them from the driver side.

Good catch.

>
> > +     return NULL;
> > +}
> > +
> > +static int read_high_speed(int buf_fd, char *data, unsigned int block_size,
> > +                        struct mmap_block *mmaps, unsigned int mmaps_cnt)
> > +{
> > +     struct iio_buffer_block block;
> > +     int ret;
> > +
> > +     /**
> > +      * This is where some buffer-pool management can do wonders,
> > +      * but for the sake of this sample-code, we're just going to
> > +      * copy the data and re-enqueue it back
> > +      */
> > +     memset(&block, 0, sizeof(block));
> > +     ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_DEQUEUE_IOCTL, &block);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* check for weird conditions */
> > +     if (block.bytes_used > block_size) {
> > +             fprintf(stderr,
> > +                     "Got a bigger block (%u) than expected (%u)\n",
> > +                     block.bytes_used, block_size);
> > +             return -EFBIG;
> > +     }
> > +
> > +     if (block.bytes_used < block_size) {
> > +             /**
> > +              * This can be normal, with some real-world data
> > +              * terminating abruptly. But log it.
> > +              */
> > +             fprintf(stderr,
> > +                     "Got a smaller block (%u) than expected (%u)\n",
> > +                     block.bytes_used, block_size);
> > +     }
> > +
> > +     /* memcpy() the data, we lose some more performance here :p */
> > +     memcpy(data, mmaps[block.id].addr, block.bytes_used);
> > +
> > +     /* and re-queue this back */
> > +     ret = ioctl(buf_fd, IIO_BUFFER_BLOCK_ENQUEUE_IOCTL, &mmaps[block.id].block);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return block.bytes_used;
> > +}
> > +
> >  static void print_usage(void)
> >  {
> >       fprintf(stderr, "Usage: generic_buffer [options]...\n"
> > @@ -249,6 +376,7 @@ static void print_usage(void)
> >               "  -c <n>     Do n conversions, or loop forever if n < 0\n"
> >               "  -e         Disable wait for event (new data)\n"
> >               "  -g         Use trigger-less mode\n"
> > +             "  -h         Use high-speed buffer access\n"
> >               "  -l <n>     Set buffer length to n samples\n"
> >               "  --device-name -n <name>\n"
> >               "  --device-num -N <num>\n"
> > @@ -356,9 +484,15 @@ int main(int argc, char **argv)
> >
> >       struct iio_channel_info *channels = NULL;
> >
> > +     static bool use_high_speed = false;
> > +     unsigned int block_size;
> > +     int nblocks = 16; /* default */
> > +     int mmaps_cnt = 0;
> > +     struct mmap_block *mmaps = NULL;
> > +
> >       register_cleanup();
> >
> > -     while ((c = getopt_long(argc, argv, "aAb:c:egl:n:N:t:T:w:?", longopts,
> > +     while ((c = getopt_long(argc, argv, "aAb:c:eghl:n:N:t:T:w:?", longopts,
> >                               NULL)) != -1) {
> >               switch (c) {
> >               case 'a':
> > @@ -396,6 +530,9 @@ int main(int argc, char **argv)
> >               case 'g':
> >                       notrigger = 1;
> >                       break;
> > +             case 'h':
> > +                     use_high_speed = true;
> > +                     break;
> >               case 'l':
> >                       errno = 0;
> >                       buf_len = strtoul(optarg, &dummy, 10);
> > @@ -661,6 +798,29 @@ int main(int argc, char **argv)
> >               goto error;
> >       }
> >
> > +     scan_size = size_from_channelarray(channels, num_channels);
> > +     block_size = scan_size * buf_len;
> > +     /**
> > +      * Need to enable high-speed before configuring length/enable.
> > +      * Otherwise, the DMA buffer will work in fileio mode,
> > +      * and mmap won't work.
> > +      */
> > +     if (use_high_speed) {
> > +             /**
> > +              * The block_size for one block is the same as 'data', but it
> > +              * doesn't need to be the same size. It is easier for the sake
> > +              * of this example.
> > +              */
> > +             mmaps = enable_high_speed(buf_fd, block_size, nblocks);
> > +             if (!mmaps) {
> > +                     fprintf(stderr, "Could not enable high-speed mode\n");
> > +                     ret = -errno;
> > +                     goto error;
> > +             }
> > +             mmaps_cnt = nblocks;
> > +             printf("Using high-speed mode\n");
> > +     }
> > +
> >       /* Setup ring buffer parameters */
> >       ret = write_sysfs_int("length", buf_dir_name, buf_len);
> >       if (ret < 0)
> > @@ -675,8 +835,7 @@ int main(int argc, char **argv)
> >               goto error;
> >       }
> >
> > -     scan_size = size_from_channelarray(channels, num_channels);
> > -     data = malloc(scan_size * buf_len);
> > +     data = malloc(block_size);
> >       if (!data) {
> >               ret = -ENOMEM;
> >               goto error;
> > @@ -719,7 +878,13 @@ int main(int argc, char **argv)
> >                       toread = 64;
> >               }
> >
> > -             read_size = read(buf_fd, data, toread * scan_size);
> > +             if (use_high_speed) {
> > +                     read_size = read_high_speed(buf_fd, data, block_size,
> > +                                                 mmaps, mmaps_cnt);
> > +             } else {
> > +                     read_size = read(buf_fd, data, toread * scan_size);
> > +             }
> > +
> >               if (read_size < 0) {
> >                       if (errno == EAGAIN) {
> >                               fprintf(stderr, "nothing available\n");
> > @@ -738,8 +903,14 @@ int main(int argc, char **argv)
> >
> >       if (fd >= 0 && close(fd) == -1)
> >               perror("Failed to close character device");
> > -     if (buf_fd >= 0 && close(buf_fd) == -1)
> > -             perror("Failed to close buffer");
> > +     for (i = 0; i < mmaps_cnt; i++)
> > +             munmap(mmaps[i].addr, mmaps[i].block.size);
> > +     free(mmaps);
> > +     if (buf_fd >= 0) {
> > +             ioctl(buf_fd, IIO_BUFFER_BLOCK_FREE_IOCTL, 0);
> > +             if (close(buf_fd) == -1)
> > +                     perror("Failed to close buffer");
> > +     }
> >       free(buffer_access);
> >       free(data);
> >       free(buf_dir_name);
>
