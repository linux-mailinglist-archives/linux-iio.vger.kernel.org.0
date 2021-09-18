Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E84107F1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhIRR5X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 18 Sep 2021 13:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhIRR5W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 13:57:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D26860F26;
        Sat, 18 Sep 2021 17:55:57 +0000 (UTC)
Date:   Sat, 18 Sep 2021 18:59:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as
 maybe unused
Message-ID: <20210918185937.1af9c5f5@jic23-huawei>
In-Reply-To: <BL0PR12MB5011F73C07A4EB499BCEBCC0C4D99@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210913112913.2148026-1-daniel@0x0f.com>
        <BL0PR12MB5011F73C07A4EB499BCEBCC0C4D99@BL0PR12MB5011.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 12:19:10 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
> 
> looks obviously good to me.
> Thanks for your patch.
> 
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> Thanks,
> JB
> 
> From: Daniel Palmer <daniel@0x0f.com>
> Sent: Monday, September 13, 2021 13:29
> To: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Daniel Palmer <daniel@0x0f.com>
> Subject: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as maybe unused 
>  
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> When building kernels without ACPI support the table is declared
> but is not used because ACPI_PTR() turns it into a NULL.
> 
> Add the __maybe_unused attribute to stop the compiler whining.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
> Ignore the first version. I'm an idiot and generated a patch,
> check that it worked, noticed it didn't, fixed it up and then
> forgot to regenerate the patch before sending it.
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 95f16951c8f4..3ef17e3f50e2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -249,7 +249,7 @@ static const struct of_device_id inv_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, inv_of_match);
>  
> -static const struct acpi_device_id inv_acpi_match[] = {
> +static const struct acpi_device_id __maybe_unused inv_acpi_match[] = {
>          {"INVN6500", INV_MPU6500},
>          { },
>  };

