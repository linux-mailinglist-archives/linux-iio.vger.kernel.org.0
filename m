Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6715D655119
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 14:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLWNyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 08:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWNyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 08:54:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C897379CE;
        Fri, 23 Dec 2022 05:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CD14B820DF;
        Fri, 23 Dec 2022 13:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91760C433D2;
        Fri, 23 Dec 2022 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671803651;
        bh=n9nPAAs1LkEhV+XfTUhhFnZbPNF80Ilkdqmj1wC3KvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pqUc0GmT3hLh0ZAP/cs12S6aNe4qu/rS665eqz+2i1CCwwmul5BfPwMz06I3EuI45
         SZQ0yZLqOCcpe7HykQ7/klSsBEyGiPvYk2uS3AITdYWdHbXkRr9TTi05LFT1p2lOsl
         dR0mROGGG3PFDLbDUgdtjp8VvmI7WHMeRNwEVI9uL29gdpZeqONnW06qvSNT/phLxQ
         5aLm4kpXPiyH+s9e4jKNSu9708fyebuT08BZddPbeiNZB/LXFCXWBH4HT4h3oIw0b4
         eUUhxmwXK3VcT3dMChLjTRbWvrGNNkbes0iNyAIEM5jBDWytUAinLud6j9AvM/rTOu
         6ZhQT7mCcZSOQ==
Date:   Fri, 23 Dec 2022 14:07:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Message-ID: <20221223140721.7702d84f@jic23-huawei>
In-Reply-To: <20221222120742.232087-1-p.jungkamp@gmx.net>
References: <20221222120742.232087-1-p.jungkamp@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Dec 2022 13:07:42 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> The hid-sensor-prox returned an empty string on sysfs in_proximity_scale
> read. This is due to the the drivers reporting it's scale from an
> internal value which is never changed from zero.
> 
> Try to query the scale of the HID sensor using hid_sensor_format_scale.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> ---
> Hello,
> 
> While trying to utilize hid_sensor_prox driver I noticed this problem.
> Should this be part of the branch created for the other patch series I
> have submitted?
> See: https://lore.kernel.org/linux-iio/nycvar.YFH.7.76.2212201525010.9000@cbobk.fhfr.pm/T/#u

Don't worry about it. I'll pick this up and pull in the hid stuff Jiri
made available once Srinivas and others have had a chance to take a quick look
at it.  Looks correct to me.

Jonathan

> 
> Regards,
> Philipp Jungkamp
> 
>  drivers/iio/light/hid-sensor-prox.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index f10fa2abfe72..3322f8e56f41 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -222,6 +222,9 @@ static int prox_parse_report(struct platform_device *pdev,
>  	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
>  			st->prox_attr.report_id);
> 
> +	st->scale_precision = hid_sensor_format_scale(usage_id, &st->prox_attr,
> +				&st->scale_pre_decml, &st->scale_post_decml);
> +
>  	return ret;
>  }
> 
> --
> 2.39.0
> 

