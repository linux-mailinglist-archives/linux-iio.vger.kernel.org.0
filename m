Return-Path: <linux-iio+bounces-5323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F78CFB23
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9B72818D6
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52DB3FE46;
	Mon, 27 May 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkFaK0Qu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C382030B
	for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797943; cv=none; b=RKdHtyrP5dtA0pc0OwSWgoRYLHLjVmO0eVl1h8n91+uhkLIkwoJMbJDivuCt+Jvfb4Gi4H+xStNtRgJEwc3hqKIO5IG/UgTZHkyhNYWwo08adeOw0obBwrBS5zaFsia5o3HfH0v6TL1ptx/wjBo9GNmiS33pRpzxflJ17Nxo/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797943; c=relaxed/simple;
	bh=RCjjYb6wM0nJAwxfMhOLnXCkB8IjXPY5d3/ddwrir6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL6Ts0SyYRqm/YPRq38Ue3d7hd7WngadMTc93alSbp63Sh8YAAyD/YN+JsvXxXragCDEu8SCmeJ7aH/b5EQd+pMtaen5Gq3Rn+wP6jlXsOhrSUEaRxJX4WhtrlQ6n/mVxczaEsnP3fhwlCeBdMvck9WcOuDfZkG9/jWT+Nko4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkFaK0Qu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df78b040314so1441031276.0
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716797940; x=1717402740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCjjYb6wM0nJAwxfMhOLnXCkB8IjXPY5d3/ddwrir6w=;
        b=WkFaK0QuR01tuVD634KbFyK9vq7BGr4R4Zk3JMk2UnOqJgMovT/25qvxONisjXtDUb
         VA8ZnvNJ3hvDVsnItviF1sJ69DhSdu39uw0bDk3/kP/cJseqgWVDw26wND+fbk+2j86Q
         VcEh721W+NhMQnOli1Ot9x0hwc7OKrDvLFbZY7ESAqOaVtVuHoCc+WT4rTYBn9wKLw8m
         JJfP1J5mBoqwHpwqDNAmJkUT2X0yP7RuSbe6dyWgzB1XSN21OXkeG9Vb6iOetGQFFmV8
         6v7XeptIfojvfQ0NVIfCI4Iagg7H37SNJk9QqQEArhxzViH0kwxSX/clRp3bZkftUCvU
         Dy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797940; x=1717402740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCjjYb6wM0nJAwxfMhOLnXCkB8IjXPY5d3/ddwrir6w=;
        b=OBgg0+1K4Ny5T+nls4D1fCXF3Dbk9QNjcfid2ABPTfnVsG2O1AcP+0RWEQooGPnQ3K
         YAytcl2SUA1tDnE94fuDPgAwZRMLXBjGx0lL6SdD7dFu5uzquUlfmGZ64AmuRM4f2Ux3
         pPbCuSS5fkbqnu62pOk2eyHU3tfQQP9FJ1lV1Z9J7HB4eg1AoGHOnj1rQrbiOOFOOv4X
         QbSWCiMsyn1O0Uh4Z+roUAsp9eWrGV6dQWOszkyGWB5V+HTaPIWSq28NIMavNc6irMEY
         157iF16pXLcUAXpcFROCDKF6imaFkviDaLgAUya6EShB/8dNWohfHPIL9JVFVtZMmoLW
         LQhQ==
X-Gm-Message-State: AOJu0Yw/I7Xl8wWBDIJVSbLWeZc0/zFgBnTKlqU9URN23CSw1Z9mZR64
	I9f/qTYTeWQU0zvwfdXSXzvilbDSZtSN7goH25gOg9lXQVSDp6kNl4NrhXCGerG1FsYEEN2+W5/
	FIE3mRFDvX5doRcr6iAE9nKAXv0+iZJ6E9pAaJw==
X-Google-Smtp-Source: AGHT+IFspza8H8xOIqspZETRE732433VV9xaajb4RmIY23jhW/bV6+/uUDSU5Nio8eFEIPU6Q6CftCfqp4wDXKQoQQ8=
X-Received: by 2002:a25:69cd:0:b0:dee:7fc3:ad6a with SMTP id
 3f1490d57ef6-df77237ad15mr7476479276.56.1716797940586; Mon, 27 May 2024
 01:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526083302.87172-1-kauschluss@disroot.org>
In-Reply-To: <20240526083302.87172-1-kauschluss@disroot.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 10:18:48 +0200
Message-ID: <CACRpkdao-fWjNBK9T5=F2gJdAe=-+CoS9o+CrJHw-u07LDJTHg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: st_accel: add LIS2DS12
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, denis.ciocca@st.com, 
	devicetree@vger.kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 10:37=E2=80=AFAM Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:

> The LIS2DS12 accelerometer by STMicroelectronics is mostly compatible
> with the LIS2DE12 variant, except the WhoAmI value (0x43).
>
> Define sensor settings for LIS2DS12, and add support in the I2C
> driver.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

We usually add support for both I2C and SPI at the same time, so please
add the five lines or so to st_accel_spi.c to support the device over
SPI as well.

With that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

