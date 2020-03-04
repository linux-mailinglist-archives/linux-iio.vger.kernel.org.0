Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6128A178FEA
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgCDL4M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 4 Mar 2020 06:56:12 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgCDL4M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 06:56:12 -0500
Received: from localhost ([46.78.45.118]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3UEW-1j8uOa17GE-000cEL; Wed, 04 Mar 2020 12:55:50 +0100
Date:   Wed, 4 Mar 2020 12:55:46 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iio: ping: set pa_laser_ping_cfg in of_ping_match
Message-ID: <20200304115546.GA8509@arbad>
References: <20200304113423.26920-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200304113423.26920-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ZfCd7m6LUx1aGZu2EkKWi9zecou5ccG8PvrJ1MnliM5bxtrGvtz
 7dO77lC/sjd/LHDFCpQCUgBDwdYrpQCFqtAa34SgdKJ4N/e2TIsSck3h/h23mhcApucSoe0
 rLS90J1Vg7vEsnjoCdn/vZFsjUVkQ4fMUBNO3BaFjW4iLPsxsO2lyCOVs43LNEKbKUm7LwN
 0uw6I3kQz/BH8f9yc03pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hkCnXUjlzoY=:ui5Asm81q/Y8BAUCpztyiq
 pWfoqs4vM7UNNWAbHmpacUgF6cWus+79kvaXvhuW6jv4vuHFaRNOm7IXI4/WBbJ8FS/KzPqCv
 fQyVDQLE24/h1e4EDirQSdvldCNuZa35ovXbQMFuVIwzn59IBofq/CjPNCuBbDudVdu9aiN46
 WORkxNg/N/2kgrj/Hn/z0EclSI1YzxQS9ODr0G0jsAOlHBcec41A5ssull/+L4xq71Eruk3vK
 aLn+Ye/1uO3Noph+XeMYSeJB8r8cPgaQz8cCXY+nz4uPi2NoeU9B5HpV/vnbSHgCeT+cBqTRG
 A9TMVoWEWOwaffv74toGcxweBhuo/lkWGxJWdEZmmEclSBg5tDvKVUPf66qbrfyQ6ShCmvTgv
 LV76MApWv9Nn9vzmPmWExfkXh6VuB1cC5y13kpLOhVo+XvxtUUzf+tGYhGkLbLjncwwJbVe90
 NSfP7ARnjufEdPx59xCCbGQlEwGeeaeRzjoh2vQi8egdLhnqz8wJgKMYgtaWOa0dFtd49vwys
 ECtQxGPTxdtOfJZj7DAaq26a9l4GUnb+3vMQrshm/fhgmXB0lK5k3pgGX+OqmHjbmA276i4BN
 JdArHo46Pn+yq7WCJKQyGw7SAXqqLVMIQTxlQbKkeGAOCQP9f9G6rvQX3QqsNSHeDHiUzRKr/
 +SAOOay/jH3cXuZFan2vZDJAOkJ56xgDgytdjZph2xYrGRZd6SrWtwXVJum+HidED0v7Y/BDI
 kOI2/kEE5QtWVCYmop9k4DbhuugWXuICCQ2fIkVEAgw8RRtQ2CH2QbOhQv53IiS3yZds4jxiC
 aSqt7mVrTGTBvPqC4jU8yTNQSgbCdYC4D+KY4DxBWRS37tt1jDdbAvrwpyckWgUxE1EDWOk
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Andreas Klinger <ak@it-klinger.de>

YueHaibing <yuehaibing@huawei.com> schrieb am Mi, 04. Mär 19:34:
> pa_laser_ping_cfg should be set in of_ping_match
> instead of pa_ping_cfg.
> 
> Fixes: 7bb501f49ddb ("iio: ping: add parallax ping sensors")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iio/proximity/ping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index 34aff10..12b893c 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -269,7 +269,7 @@ static const struct iio_chan_spec ping_chan_spec[] = {
>  
>  static const struct of_device_id of_ping_match[] = {
>  	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
> -	{ .compatible = "parallax,laserping", .data = &pa_ping_cfg},
> +	{ .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg},
>  	{},
>  };
>  
> -- 
> 2.7.4
> 
> 
