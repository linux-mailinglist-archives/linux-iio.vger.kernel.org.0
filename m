Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293C43A0D17
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhFIHFt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 03:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhFIHFt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 03:05:49 -0400
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5829C06175F
        for <linux-iio@vger.kernel.org>; Wed,  9 Jun 2021 00:03:54 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id B17D460109
        for <linux-iio@vger.kernel.org>; Wed,  9 Jun 2021 07:03:52 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.65.211]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=freedom.nl; s=default;
        t=1623222231; bh=DD92sLcXlSZHBTns6U/B0Vc9GgFY1Se0/ckoBbrCA1M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G49Gm2XrDjYsFMPvRY59c+VMRgRcIk6zvZGh0ZmMkAJIaPzG18IvsQCzZb4HLoDqe
         aRvkRSzcxDws/Q4eoyHTx8TSWN1FWRvLMCMVpubjZjDWOEWLqBIzXaMiE/vbOOfWPh
         h6QOVf69s9Tr8gBiY1BM3KESTnwzLAX17csJneHI=
Subject: Re: active_scan_mask
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Henk Medenblik <iio-developer@freedom.nl>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
 <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
 <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
From:   Henk Medenblik <iio-developer@freedom.nl>
Message-ID: <b5a7e616-5d3b-5899-5c51-255c82a33e40@freedom.nl>
Date:   Wed, 9 Jun 2021 09:03:49 +0200
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear Alexandru,

> Hmm, so the "zerocopy" branch isn't  at v0.21.
> It's something much older [ ~6 years ? ].
> Though the kernel active scan mask is unrelated to libiio, since
> iio_readdev is being used in different sessions.
>
> The 4.14 version of the kernel, isn't quite new.
> There was some recent fix with regards to active scan-mask computation.
> But I am not sure if it's related to this.
>
> Will try to make some time to do some testing on this.
>
I believe it is a bug which still exists in the adi linux kernel sources.
In industrialio-buffer.c :

static int iio_channel_mask_clear(struct iio_dev *indio_dev,
     struct iio_buffer *buffer, int bit)
{
     unsigned int ch;

     clear_bit(bit, buffer->channel_mask);

     memset(buffer->scan_mask, 0, 
BITS_TO_LONGS(indio_dev->masklength));  <---------
     for_each_set_bit(ch, buffer->channel_mask, indio_dev->num_channels)
         set_bit(indio_dev->channels[ch].scan_index, buffer->scan_mask);
     return 0;
}

seems so unnecessary complex...
The memset does not clear the scan_mask completely.

Why not simply :

clear_bit(bit, buffer->scan_mask);

Regards

Henk

