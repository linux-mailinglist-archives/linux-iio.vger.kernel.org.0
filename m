Return-Path: <linux-iio+bounces-2520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AC8537E1
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70821F29756
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F85FF0E;
	Tue, 13 Feb 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsjZ5GY1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2A5F54E
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845439; cv=none; b=kf6cwBQA45KWOkHxL8Vxlr+2QEbc4ITtbtmqwRka+iYTTXBkRgeuMZCQSgck35aqj8mKk5Dqbt/ye5bnLsaU7muMGVuAXJ2FsYMtGxzMCvP0UtnyZDkcz0tp0RIlqxIrAfcu2LDiF8zEnpn2JqZUISALoCG8GgdaikaZBxcsCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845439; c=relaxed/simple;
	bh=NVFAIzHOQXHtH2Hcdy261PFV7ecM2eZ0YNGv+FRrbTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J90Vj3/TnAK6wB/7sgbaWpa5Hsl750cYgjdEH5CFv5t9IytLys3bttWKE5gTLUJw0YZZh/+7kjSl+UgoC+3FiwDRtFQtqs+2LZTKbTTqBeYx/SprqfYWTIRiRObcWR/XTSbZE4lEl5DDmwLcfwB4OUiHfrRvaCEVDltUkUkOhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsjZ5GY1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so175578366b.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845436; x=1708450236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVFAIzHOQXHtH2Hcdy261PFV7ecM2eZ0YNGv+FRrbTw=;
        b=XsjZ5GY1eQEaYTXtGV4SagE85bzhJaoYi472oO1NCQxTAmYjgJraMb7mRpKFaJwqdp
         lsPIDIlzIvw0MqZJs2MdmTQPO+GSMyYtfpgpu1Nhc0yfJMok8CEh12GOs6qrSOCyKzPd
         RyQSZnFjiPw/60/jKtTKyUdmmRGnZKA/oc13uDNWO798oMtCNqmZo3vtjwb5oOOe9LhA
         fxDI0jlplfWMOUZeqxLA6yi8HDq4QP8Cy4iobs8aGJ2XSiB7tsVccBtgxAr9pUXqI7bw
         XZytxF1H9mVs71vC0Lfnz5sP+SmJeQMCQCReaws7J1NrER4I+vRHGH+aUexFBhtK3jfR
         UYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845436; x=1708450236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVFAIzHOQXHtH2Hcdy261PFV7ecM2eZ0YNGv+FRrbTw=;
        b=YryrbKTObO3aq8N6g0poA0JjAM8QHwCjlNaHAi1VIt1Tu3/n4fMDootQ8fvz6673AT
         8D2yDsgFF8x2qSjw2UzJ+8H34vM8ZTF+h+HlwkSiUUHrAVPaPeBvPajuaU2O6hovJjjV
         BxyuP6wJcr4/WHD/aS64SpmVhxJ6fojUygGzfDumGAhQRW7iBKgEA+2NmKcJ1z2x412X
         RL1uJ24/HzgKxZRM0/TcOaIiUmUkaRlAEK28JBD6dPIDRDHiIMhCSDBWzv7ouQvUYG0W
         jGVmPYkDzC90lsakj7ilVr8Y3WCAVeUnJQHE6xgTJxi5YF6o83fVbVPYnvtpqz52sv+x
         tB2A==
X-Forwarded-Encrypted: i=1; AJvYcCW9Nd9i87afzehN9YdeRAjfc8OZnCEmsJnQansVjkM/HxrwJoUUsZYloVkZ3L8/qSh+iCnqe24Sgr3gZXOlMOSn4wntBkZN1xUj
X-Gm-Message-State: AOJu0YzuIVoryGfqO1SiG4RfHLYtFF3YkPJY10JNOvfXHL73Pl4r4OI/
	oHNEsyju12aWTbkBx+tveFdimGCjnweBVxvrq6vKWEdSo5AaETI+92o88x//0Men0cOPe4LOP1Y
	Gc+NkKCNg+eYjgBwgbT8LdKEj0Sg=
X-Google-Smtp-Source: AGHT+IG7uNIkr3evRsc5oZDxeFQvZOPEtTbi5sjBOUs0mudIj+bXuT6qIsYtRFG2rwI2IeWhhRduZOrpSA7HUZvtjfQ=
X-Received: by 2002:a17:906:48da:b0:a3d:1458:525d with SMTP id
 d26-20020a17090648da00b00a3d1458525dmr16406ejt.25.1707845435362; Tue, 13 Feb
 2024 09:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
 <20240213023956.46646-1-jlobue10@gmail.com> <CAHp75VeBqKiEWHyRjJt62VvrGKjG9S+kgMrbYEPBap311ZtZVw@mail.gmail.com>
 <4917806.31r3eYUQgx@nobara-ally-pc>
In-Reply-To: <4917806.31r3eYUQgx@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 19:29:58 +0200
Message-ID: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
Subject: Re: [PATCH v1] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:14=E2=80=AFPM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
> On Tuesday, February 13, 2024 2:49:24 AM PST Andy Shevchenko wrote:
> > I'm lost. You sent a lot of patches / patch series all of which are v1.=
 Can you:
> > - use versioning (`git format-patch -v<X>...`, where <X> is a plain
> > version number)
> > - add a changelog here (after the cutter '---' line) to explain the
> > history of the changes
> > ?
>
> Yes, I will do this. The changes so far included dropping the no longer
> necessary DMI quirks portion in the bmc150 driver. I understand from
> your comment that we want to add a comment in the bmc150 driver though
> to explain what is going on with duplicate ACPI identifiers in different
> drivers. I will add a similar comment in the bmi323 driver. The changes
> so far also included the fixes that you requested earlier in bmi323:
> dropping the duplicate header include entry (included already in other
> header file), removing the unnecessary comma in the ACPI match table
> portion, and removing the ACPI_PTR when invoking the ACPI match table.
>
> > Since there is a collision please add a big comment in _both_ drivers
> > before such ID to explain what's going on.
>
> I will do this and add a changelog after the cutter as requested. Since t=
here
> are some changes from my initial submission attempt and with the addition=
al
> requested comments, is v2 going to be okay to use so there's no ambiguity
> about which patch version to use?

Sounds good as we seem never to have seen v2 on the topic.

> I will attach the version label with
> git format-patch as requested. Thanks.


--=20
With Best Regards,
Andy Shevchenko

