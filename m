Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4463D1E981E
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgEaO1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgEaO1e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:27:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC782076B;
        Sun, 31 May 2020 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590935253;
        bh=NKrkeo6UXWPyI9u8qha+YBNOzdVtFMBruVoUoj76jBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s/lo1Zbt/ogvrQA8qvH/7UmEOvxYKustGfl5DZeAfRI1nUThdzUWujSDU5ZXV7Ith
         AoJyYFrVFSfLQlkuK7xHp/l7m0BN/eWFaAB/eWEZea2KD8Va5A+AsPfScAWjvF7HFt
         ht+G4KYBkG90Me/Q8lhpbIu7EPXKzLrVTzl9PWxk=
Date:   Sun, 31 May 2020 15:27:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v4 3/5] iio: imu: bmi160: fix typo
Message-ID: <20200531152728.24f96084@archlinux>
In-Reply-To: <20200525164615.14962-4-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
        <20200525164615.14962-4-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 18:46:02 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Fix a typo in MODULE_AUTHOR() argument.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
applied

Thanks,

J
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 6af65d6f1d28..77b05bd4a2b2 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -853,6 +853,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  }
>  EXPORT_SYMBOL_GPL(bmi160_core_probe);
>  
> -MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
>  MODULE_DESCRIPTION("Bosch BMI160 driver");
>  MODULE_LICENSE("GPL v2");

