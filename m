Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A520755B45E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jun 2022 01:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiFZWfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiFZWfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 18:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663922DDF
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8D66100A
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 22:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F6C34114;
        Sun, 26 Jun 2022 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656282944;
        bh=qkvlMEll5u8wd8PGC1VVTE46ePAE7fMXxIGLpM4ZOH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ui5520A105OvHklP8SzAjWKdxyz6M6r7Ig6gvwIDI6lg4niscLeQgYYRZwS4mPnXo
         2Iqi3djhFfIsFlp8KarYwSE9Op+x8Rjz5xz00DpvTk854OzL36d9MfQtHVDAtBY1Z3
         bNyRaVxGZrZq9N3md0s+SnUnBG+hy8KhVBplu26uSml5vgoVpzsW2I1jOy/Ily0+S+
         3roe59+yv7BojJwRStQjPXMi9xOq7y7uyk+NVcm7E02lGFxqzZgJJr8qdyH4ainShM
         bs8vKEc00twTZ++QjLIgN+iPWLjInGu1op6EWosrbKSAj8StDY/7Q/d+ETJa+/O+er
         zP8UvFeC0e6yQ==
Date:   Sun, 26 Jun 2022 23:35:39 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>
Subject: Re: [PATCH 2/4] iio: ABI: max31865: Drop
 in_filter_notch_centre_frequency as in main docs.
Message-ID: <20220626233539.7a8e6dca@sal.lan>
In-Reply-To: <20220626165511.602202-3-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-3-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun, 26 Jun 2022 17:55:09 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As this is the last element in the file, also delete the file.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> Cc: Navin Sankar Velliangiri <navin@linumiz.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-temperature-max31865        | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> deleted file mode 100644
> index 349089e4f2d6..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
> -KernelVersion:	5.11
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Notch frequency in Hz for a noise rejection filter. Used i.e for
> -		line noise rejection.
> -
> -		Valid notch filter values are 50 Hz and 60 Hz.
