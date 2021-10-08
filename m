Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A77426250
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 04:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhJHCLp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 22:11:45 -0400
Received: from mx22.baidu.com ([220.181.50.185]:47086 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229501AbhJHCLp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 22:11:45 -0400
Received: from BC-Mail-HQEx02.internal.baidu.com (unknown [172.31.51.58])
        by Forcepoint Email with ESMTPS id E22C4A2638C72485423E;
        Fri,  8 Oct 2021 10:09:43 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEx02.internal.baidu.com (172.31.51.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 8 Oct 2021 10:09:43 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Oct 2021 10:09:43 +0800
Date:   Fri, 8 Oct 2021 10:09:50 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: light: noa1305: Make use of the helper
 function dev_err_probe()
Message-ID: <20211008020950.GA290@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210928014156.1491-1-caihuoqing@baidu.com>
 <20210928014156.1491-4-caihuoqing@baidu.com>
 <20211007183826.67c0fed4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007183826.67c0fed4@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07 10月 21 18:38:26, Jonathan Cameron wrote:
> On Tue, 28 Sep 2021 09:41:55 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > When possible use dev_err_probe help to properly deal with the
> > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > in the devices_deferred debugfs file.
> > Using dev_err_probe() can reduce code size, and the error value
> > gets printed.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> Applied this patch to the togreg branch of iio.git and pushed out as
> testing for 0-day to try it out.
> 
> Note I didn't pick up 1 and 3 from this series and will expect to see
> a v3 of those or reply to the relevant reviews.
Sure, I will resend some patches according to your feedback.
Just took my vacation during 1~7th Oct.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > v1->v2: Remove the separate line of PTR_ERR().
> > 
> >  drivers/iio/light/noa1305.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> > index a308fbc2fc7b..71a322227429 100644
> > --- a/drivers/iio/light/noa1305.c
> > +++ b/drivers/iio/light/noa1305.c
> > @@ -217,10 +217,9 @@ static int noa1305_probe(struct i2c_client *client,
> >  	priv = iio_priv(indio_dev);
> >  
> >  	priv->vin_reg = devm_regulator_get(&client->dev, "vin");
> > -	if (IS_ERR(priv->vin_reg)) {
> > -		dev_err(&client->dev, "get regulator vin failed\n");
> > -		return PTR_ERR(priv->vin_reg);
> > -	}
> > +	if (IS_ERR(priv->vin_reg))
> > +		return dev_err_probe(&client->dev, PTR_ERR(priv->vin_reg),
> > +				     "get regulator vin failed\n");
> >  
> >  	ret = regulator_enable(priv->vin_reg);
> >  	if (ret) {
> 
