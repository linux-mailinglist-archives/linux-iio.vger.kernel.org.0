Return-Path: <linux-iio+bounces-5312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A198CF448
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E222815F5
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9EDF71;
	Sun, 26 May 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEscVdFU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B318B676;
	Sun, 26 May 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716727118; cv=none; b=TSfI5NOEYTMDb9ahm9rW4OyZrmBe3QdBMMBc+k4LjBmjtB+IzOxOxlYgMMElzu4afXGqn0EzhHG1XSgO0ZWoaTpgslSLueXC8KS/mjyabn8QlBMguaQeXmG555LMaA8o1uqshWMT8beEQtkAK1AZGVgsqj/3RywPZFiVlgKpa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716727118; c=relaxed/simple;
	bh=Vgc3HyTkBbyE1nomNcxxQDYP1xmBd93WDg0GRhyGgCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pthYanqSIH5dDjJyyi5RhtZe4TU6n+5Wymld0+LmoVgLMEGe1R1woeUScZT/oPENJwFpj6GQvWopKDDWO8ePniT4gBhHkHUeZG5K9nKQPRueF+2A9bZ8HFE9sicCoZeevsiZdPWy2Hbp0GVq4B0oKUr8QF28ps9uF+qbph+ZC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEscVdFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ED3C2BD10;
	Sun, 26 May 2024 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716727117;
	bh=Vgc3HyTkBbyE1nomNcxxQDYP1xmBd93WDg0GRhyGgCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEscVdFUuUnXFhmBXey7WgbTvg+H/9sML8MVtL4dLtelbQhsts6H9zdbAD4BBXtVo
	 iix36YUqcUCptf/LahGz9akQOyj7idHDzLvsFUx8eqfzb84AdHXE4+DMXfGod+U9v/
	 HT678QzyujW5ReyQJVb6sQMNI11Fv7LA0J8qbRbtw5ei5bBn37+JyT0ZH1XP2xyfi8
	 R8HwGppSeB7XwftRWmjWxnyYrfTjTXewTTi7Pf8P2JVstCEh4EpzxEL4lHkyig0kCx
	 CL6dnJZThIjZWv9zSKLCZ3NO69TP+xvj9IFjdquje6EXAv8TPuQaEWaz2eEg6qSsdc
	 kL3xXT154wKyw==
Date: Sun, 26 May 2024 13:38:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v4 04/10] iio: imu: adis_buffer: Add buffer setup API
 with buffer attributes
Message-ID: <20240526133803.133cd866@jic23-huawei>
In-Reply-To: <20240524090030.336427-5-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	<20240524090030.336427-5-ramona.bolboaca13@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>  /**
> - * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
> - *					  the managed adis device
> + * devm_adis_setup_buffer_and_trigger_with_attrs() - Sets up buffer and trigger
> + * for the managed adis device with buffer attributes.
>   * @adis: The adis device
>   * @indio_dev: The IIO device
> - * @trigger_handler: Optional trigger handler, may be NULL.
> + * @trigger_handler: Trigger handler: should handle the buffer readings.
> + * @ops: Optional buffer setup functions, may be NULL.
> + * @buffer_attrs: Extra buffer attributes.
>   *
>   * Returns 0 on success, a negative error code otherwise.
>   *
> - * This function sets up the buffer and trigger for a adis devices.  If
> - * 'trigger_handler' is NULL the default trigger handler will be used. The
> - * default trigger handler will simply read the registers assigned to the
> - * currently active channels.
> + * This function sets up the buffer (with buffer setup functions and extra
> + * buffer attributes) and trigger for a adis devices with buffer attributes.
>   */
>  int
> -devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
> -				   irq_handler_t trigger_handler)
> +devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev *indio_dev,

Trivial, but as you are doing a v5 anyway for Nuno's feedback
please add a line break after adis,

Whilst for the following lines readability would be hurt by breaking the lines
that isn't true for this first line.

> +					      irq_handler_t trigger_handler,
> +					      const struct iio_buffer_setup_ops *ops,
> +					      const struct iio_dev_attr **buffer_attrs)
>  {



