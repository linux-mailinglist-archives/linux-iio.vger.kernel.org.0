Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568691F88F4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFNNcw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNNcw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:32:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8492068E;
        Sun, 14 Jun 2020 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592141571;
        bh=uTfpNWRvYWOrqnmeI/EwAdErXP1TsRC5QVhd45GCRn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jsEOrTaKRDmAnCW7XJncWy1qf6HpVO4HnKnazVn1q6PHBrdUIorBgxnoacxPwuj2Y
         2SjTUHhWu2n5V5FTpCaxkugGXiuXgFQDm/o+B/eEuT1S2gsNveuNWxGr0lpnwPDizO
         Jz0l0DOHrPjuJJTsIqChTttoMszydfij89VDHuG8=
Date:   Sun, 14 Jun 2020 14:32:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio: common: fix spelling mistake
Message-ID: <20200614143246.42b4f1d5@archlinux>
In-Reply-To: <20200609162943.867-1-f.suligoi@asem.it>
References: <20200609162943.867-1-f.suligoi@asem.it>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Jun 2020 18:29:43 +0200
Flavio Suligoi <f.suligoi@asem.it> wrote:

> Fix typo: "tigger" --> "trigger"
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Sorry, was reading my email backwards and picked up same
fix from Keyur Patel.

Thanks though,

Jonathan

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c831915ca7e5..4888fb23d801 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -352,7 +352,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		} else {
>  			/*
>  			 * The only way to get samples in buffer is to set a
> -			 * software tigger (systrig, hrtimer).
> +			 * software trigger (systrig, hrtimer).
>  			 */
>  			ret = devm_iio_triggered_buffer_setup(
>  					dev, indio_dev, NULL, trigger_capture,

