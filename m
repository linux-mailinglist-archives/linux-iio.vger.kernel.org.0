Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88945AC5A3
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiIDRRz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Sep 2022 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDRRz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2022 13:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11033A2F
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 10:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9639B60FCB
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 17:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BF5C433D6;
        Sun,  4 Sep 2022 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311873;
        bh=zOuAHQAquyEhdC1g0oEkEl88lIN1jueZXotpxmUA5ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ldsH7Okc1E4h9Ksmrmz/MoeOoGNaT0IzmeWZ0REEEoBebIwfklVadAZTJSQ8rL9Hb
         ShDGqqG3LYVMZdLsx1QlvroS8NvA1ynsKOxO3S1nj8MJva9CZxlGx0bfMW6+6p7j0Y
         IqQBkwiooapqi/Nxw0mgjZxQKBRqmQT4H+El9Gbvbj8e59m6QxttE+vrLCzmbjlh8K
         o/CjknfvOOM+VBArlGkpw94c+uFjnRdPPJDvn2MBW0O9oz9kwNLm4irYT5XH7ndSe9
         QDyvc+JoNcIvaMcO0GugcZtyjQVPkOdsob/tRolrmP5MO57JQmtx1MUEHJJXDUHIvl
         JDtQzVpwqxv4A==
Date:   Sun, 4 Sep 2022 17:43:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: pressure: icp10100: Switch from UNIVERSAL to
 DEFINE_RUNTIME_DEV_PM_OPS().
Message-ID: <20220904174345.06903089@jic23-huawei>
In-Reply-To: <FR3P281MB175798EA1774B9FCE677B7FECE6B9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220807190414.1039028-1-jic23@kernel.org>
        <20220807190414.1039028-2-jic23@kernel.org>
        <FR3P281MB175798EA1774B9FCE677B7FECE6B9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 16 Aug 2022 13:13:52 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
> 
> looks good, thanks for the patch.
> 
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Applied
> 
> Thanks,
> JB
> 
> 
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, August 7, 2022 21:04
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Cc: Paul Cercueil <paul@crapouillou.net>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Crt Mori <cmo@melexis.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Subject: [PATCH 1/2] iio: pressure: icp10100: Switch from UNIVERSAL to DEFINE_RUNTIME_DEV_PM_OPS(). 
> _
> [CAUTION] This is EXTERNAL email. Do not click any links or open attachments unless you recognize the sender and know the content is safe.
> 
> ======================================================================
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The suspend and resume callbacks in this driver appear to be safe
> to call repeatedly, but why do so when we can use the
> DEFINE_RUNTIME_DEV_PM_OPS() macro to supply callbacks that check if
> we are already runtime suspended before doing unnecessary work.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
> _drivers/iio/pressure/icp10100.c | 10 +++++-----
> _1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
> index af4621eaa6b5..b62f28585db5 100644
> --- a/drivers/iio/pressure/icp10100.c
> +++ b/drivers/iio/pressure/icp10100.c
> @@ -595,7 +595,7 @@ static int icp10100_probe(struct i2c_client *client,
> ________ return devm_iio_device_register(&client->dev, indio_dev);
> _}
> _
> -static int __maybe_unused icp10100_suspend(struct device *dev)
> +static int icp10100_suspend(struct device *dev)
> _{
> ________ struct icp10100_state *st = iio_priv(dev_get_drvdata(dev));
> ________ int ret;
> @@ -607,7 +607,7 @@ static int __maybe_unused icp10100_suspend(struct device *dev)
> ________ return ret;
> _}
> _
> -static int __maybe_unused icp10100_resume(struct device *dev)
> +static int icp10100_resume(struct device *dev)
> _{
> ________ struct icp10100_state *st = iio_priv(dev_get_drvdata(dev));
> ________ int ret;
> @@ -626,8 +626,8 @@ static int __maybe_unused icp10100_resume(struct device *dev)
> ________ return ret;
> _}
> _
> -static UNIVERSAL_DEV_PM_OPS(icp10100_pm, icp10100_suspend, icp10100_resume,
> -__________________________ NULL);
> +static DEFINE_RUNTIME_DEV_PM_OPS(icp10100_pm, icp10100_suspend, icp10100_resume,
> +_______________________________ NULL);
> _
> _static const struct of_device_id icp10100_of_match[] = {
> ________ {
> @@ -646,7 +646,7 @@ MODULE_DEVICE_TABLE(i2c, icp10100_id);
> _static struct i2c_driver icp10100_driver = {
> ________ .driver = {
> ________________ .name = "icp10100",
> -______________ .pm = &icp10100_pm,
> +______________ .pm = pm_ptr(&icp10100_pm),
> ________________ .of_match_table = icp10100_of_match,
> ________ },
> ________ .probe = icp10100_probe,

