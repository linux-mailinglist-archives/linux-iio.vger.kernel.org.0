Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774C4F04BD
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353575AbiDBQMH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355029AbiDBQMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 12:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A64C275FF;
        Sat,  2 Apr 2022 09:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED394B80A36;
        Sat,  2 Apr 2022 16:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A16C340EE;
        Sat,  2 Apr 2022 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648915811;
        bh=Hyx7lu75/G4RsuKOXrcnoLbyXhT2t4mTxGnGPGH7SWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kwQSsXzYii+uajDWAwmOgV5coT3H+VYo2LyNAnZZEyxOv6zcz2x9hxDzvvt7czjzY
         SMdaLBys8YXdWZulPdkovb6rZ+LA55jv+J5MWB0zZG5OjkjbyyhrTu2olAWOEDCq4q
         Yfk/fglEX3T/gK3R0+ZWXIzEn5ihC5MFuyMpqcnnO68acJX+qXiNOcWeuP6H6+5Osc
         lnxILeVfGxSo7r3IW5PX7jh2kVmBCOxcOd/1H4G01tn4LzA8XOXMJ23EahM9T86vmA
         NJQNpb9TW49d5l0DF5OicSer2GS+tXdJQci5z85zQ95IxlfThP7vFtroKqx4Vfg4Jw
         tylhFIJR3rejg==
Date:   Sat, 2 Apr 2022 17:17:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx
 device bindings
Message-ID: <20220402171753.638e71d5@jic23-huawei>
In-Reply-To: <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
References: <cover.1648893892.git.lorenzo@kernel.org>
        <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
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

On Sat,  2 Apr 2022 12:09:30 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Hi Lorenzo,

This runs in to the same feedback that was recently had for
https://lore.kernel.org/all/?q=Add+support+for+ICM-20608-D
but in a more extreme sense as this one presents the same whoami value
as for other sensors already supported.  Things are made more
fun by the fact that sensors with the same WAI seem to have different
features (presence or not of a sensor hub - is there any documented
way to detect that?). 

As such, we should really be listing this as compatible with one 
of the parts that is already supported such as the
LSM6DSR.

For that we'll need a slightly more complex binding and it would
have the side effect that if the match was on that compatible we
would list the name as whatever that part is.

I'm not sure that really matters a great deal, but it could in theory
create a userspace ABI change if we later needed to add explicit support
for the part due to some real differences not indicated by the WAI value.

An extension is whether we should relax the need to match on WAI if
the part is considered compatible.  I guess that depends on just how
compatible we think they are.

So I see several steps to this process.

1) Add fallback compatibles for existing entries to first one with same WAI and
   same feature set.
2) Add fallback compatibles beyond that to first part introduced with particular
   characteristics.  For this we'd also want to have the driver relax its
   handling to just warn if the WAI isn't listed for any of the parts that
   share a particular set of characteristic (so you'll have to loop over the local
   array again to check):
https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c#L1197
Same argument applies as for the mpu6050 that, whilst we should modify that code to
cope, it's not a prerequisit for adding the compatible fallback to the binding.
Personally I'd like it to be the first patch in the series that modifies the
binding though.  Note it'll be easy to add the fallbacks for this new part as
no mainline trees presumably use it.  To 'fix' the rest we'll have to find
and update any DTs in mainline.

Note this won't stop us needing to add compatibles to newer kernels (at very
least to the dt-binding, but probably also the driver), but it should help a newer
DT 'work' with an old kernel.

Jonathan


> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 0750f700a143..23637c420d20 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -31,6 +31,7 @@ properties:
>        - st,lsm6dsrx
>        - st,lsm6dst
>        - st,lsm6dsop
> +      - st,asm330lhhx
>  
>    reg:
>      maxItems: 1

