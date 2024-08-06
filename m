Return-Path: <linux-iio+bounces-8290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4B9495D3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F275B287DE
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B238F91;
	Tue,  6 Aug 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5hBe0HM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FD4653A;
	Tue,  6 Aug 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961956; cv=none; b=DiJU7widbRu3iWQH0sq9gLCtjZkfqkNwiE3TFtxKm98/gYFUHxsct633Z2mJaxndAHN/D8DCdxwlx6C+ofrkVpqxhce+2gprQYhqnzbYvAb0gWT806f2GFLrElR+8hmZdTu+GSlQpEDxJPE1Fu557FAtpcMTRjccHoGT+F0KJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961956; c=relaxed/simple;
	bh=0eny/Vsu4sJKj0EvuFo6PYlBjSKdQR/M070SUXqqkUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7/smbMNAqG5tGTnwzQa3LpxkMDEPyOuh88BBkzZOKzyLMo9qAq+Y8UqTs8bWQ617ozHDjQA1iQ0weBsCe4Av9EqCwDjDalSklt0xRmBawj5ay2dLgyKZ/n5G4Amnhpc6xJZppnKR1vAR6L24b7H5t18oBiJz9t5smHsXWtp7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5hBe0HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DDAC32786;
	Tue,  6 Aug 2024 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722961955;
	bh=0eny/Vsu4sJKj0EvuFo6PYlBjSKdQR/M070SUXqqkUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5hBe0HMGJ70cTJe0Kb9gvemtKIOvTzhhhfVqXHtIERGgx11A0mqoiKngH5XldSMH
	 pjInfnfJpGzOM297JCj3woAk9TIB0CaZ93DeSFKad7Npf197+jEC8Dph4Euxc0DnSg
	 snM4uyOrl8YVIZQ6HsXgOEHVJr+yLBpu4E8WFaAiTFxsx4MQpAX8IWtSkuvOWX4NfD
	 ixR1Buo/b4eL3ydZabUI84gBoIuCfraD8izt3iUpfjHAovLhIl1u8gk3dtE7rxysbU
	 bq0GtbWhsi5vuZitU0WbjitxERelrwJaZZiolnUIp6aFcoYo+vxhYmlMkhECJcCkyV
	 LEyKDMl3qDYXQ==
Date: Tue, 6 Aug 2024 17:32:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 biju.das.jz@bp.renesas.com, nuno.sa@analog.com, skhan@linuxfoundation.org,
 rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma180: Fix dataready interrupt to use INT2
 pin
Message-ID: <20240806173228.264f0114@jic23-huawei>
In-Reply-To: <20240805173237.475797-1-abhishektamboli9@gmail.com>
References: <20240805173237.475797-1-abhishektamboli9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 23:02:37 +0530
Abhishek Tamboli <abhishektamboli9@gmail.com> wrote:

> Update the interrupt configuration to use the INT2 pin for
> the dataready interrupt.
> 
> Address the FIXME: support using the INT2 pin.
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
Hi Abhishek,

That's not the intent of that FIXME.  It's pointing out that the driver
does not currently support the wiring configuration where only INT2 is
connected.  The change you have here breaks the configuration where
only INT1 is wired or both are wired (as it will register the
interrupt handler on the int1 pin, not int2).

I'm guessing that is the situation you have is int2 only?

To handle this you need to add the firmware queries to identify the
interrupt by name. See for example driver/iio/imu/bmi323_core.c
bmi323_trigger_probe()

	fwnode = dev_fwnode(data->dev);
	if (!fwnode)
		return -ENODEV;

	irq = fwnode_irq_get_byname(fwnode, "INT1");
	if (irq > 0) {
		irq_pin = BMI323_IRQ_INT1;
	} else {
		irq = fwnode_irq_get_byname(fwnode, "INT2");
		if (irq < 0)
			return 0;

		irq_pin = BMI323_IRQ_INT2;
	}

This defaults to INT1 if available, but will find INT2
if interrupt-names is provided in DT and specifies that only INT2
is present.

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 6581772cb0c4..d44409afffbf 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -126,7 +126,7 @@ struct bma180_part_info {
>  #define BMA250_SUSPEND_MASK	BIT(7) /* chip will sleep */
>  #define BMA250_LOWPOWER_MASK	BIT(6)
>  #define BMA250_DATA_INTEN_MASK	BIT(4)
> -#define BMA250_INT1_DATA_MASK	BIT(0)
> +#define BMA250_INT2_DATA_MASK	BIT(7)
>  #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
>  
>  struct bma180_data {
> @@ -425,10 +425,9 @@ static int bma250_chip_config(struct bma180_data *data)
>  	if (ret)
>  		goto err;
>  	/*
> -	 * This enables dataready interrupt on the INT1 pin
> -	 * FIXME: support using the INT2 pin
> +	 * This enables dataready interrupt on the INT2 pin
>  	 */
> -	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT1_DATA_MASK, 1);
> +	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT2_DATA_MASK, 1);
>  	if (ret)
>  		goto err;
>  


