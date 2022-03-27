Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208504E881E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiC0OjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiC0OjX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 10:39:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEB36322
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 07:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39629B80D0F
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 14:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C253C340ED;
        Sun, 27 Mar 2022 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648391860;
        bh=Q79XG2bdBp1VgvCHvaTxk9Y+A/ZGy/LARPVjtnUXBao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qyTwEhm7Kx2MFZ4MtHOsXEl+Coes7O3Bg85YN7jdIGd2CoPRWg8wuFcqcnCHjmRle
         d9xQ/6jyrswU9wEx6CZ20A6m2a+IMItvuykfdh8tZetlRM2UhuspHdqGTx6SQRXnwg
         nMY58de/NhJPwENo/Zug7TWlnvRl9O7mAsR0Tg9d4a0HIwXg/7PslF1snoXA8RB6yJ
         x7R5Lpaqe4ZPr6y31m5IUJ+JQH8PQyTOKIdNQ3zy2UjqdZ/cfOJTt8rm0Fm/sLYN5V
         ldFOeJcJE3cuISrIHfMwzcYDMVfxciHUfTKQLWUhku4OciPajYs+weV6huSlwGrVR3
         jd1hbWS2rF7Pg==
Date:   Sun, 27 Mar 2022 15:45:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] tools:iio: Fix the potential stack overflow risk
Message-ID: <20220327154513.0eaa8dfc@jic23-huawei>
In-Reply-To: <20220324110157.13143-1-jianchunfu@cmss.chinamobile.com>
References: <20220324110157.13143-1-jianchunfu@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Mar 2022 19:01:57 +0800
jianchunfu <jianchunfu@cmss.chinamobile.com> wrote:

> Add judgment to fix the potential stack overflow risk.
> 
> Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
Yikes.

Whilst it doesn't promise to be good code (it's meant to show
the principles, not for anyone to use it) the error handling
in this function is a mess :( 

Whilst your change here looks good I think this function needs
a closer look so we fix them all together.

Just glancing at it, the decision on whether to go to the unified
error handling or return without doing anything seems entirely random.

If you want to take on a more general rework of the error handling
in that function it would be great. If not I 'might' get to it at
somepoint....

Thanks,

Jonathan


> ---
>  tools/iio/iio_generic_buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 2491c54a5..733fc21c2 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -487,6 +487,10 @@ int main(int argc, char **argv)
>  			return -ENOMEM;
>  		}
>  		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
> +		if (!trigger_name) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>  		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
>  		free(trig_dev_name);
>  		if (ret < 0) {

