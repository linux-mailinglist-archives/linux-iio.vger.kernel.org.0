Return-Path: <linux-iio+bounces-12710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303499D9E21
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 20:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41F2283F8E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8681DE4E3;
	Tue, 26 Nov 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBGFP9kP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677C1DE4FF;
	Tue, 26 Nov 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650998; cv=none; b=bNm8G681VChH5FeRjAEIcS5Th6hJ/F5tpTnwBHkyQCYhStHfJlYJh9BAajYcHlKcKB8Yd+4LW/NBDqCWWp2lV2VQ+ZdoHEuc0QUL93nMIWIRMT65kA1DS6Hia0TPzYztwjg+jnL09q7nQHf7o4A8suu+qHX9RWVg2lUVZHyrlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650998; c=relaxed/simple;
	bh=VGkyr0KqJCkxfU95x+cMx7RyBH0/dieElDzoNvSFXUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APEkx8TUpCVV3RkVa6lU+jH0uZdSWvJSIKbdf1wNLeWQFtwchpR6u3TUVYeIeyF7Nxy+xFh+R0iGHSXwTz7tF02N6w2UcaY+8oyI2q69s51cfAV1XnWBOQQIFUIqfcoh9CIs+68I9xO9v8jR3TULfIdnGM4qM+67tG2qpffWZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBGFP9kP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso1327883e87.1;
        Tue, 26 Nov 2024 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732650995; x=1733255795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xQ0j+0GPxTIxCI2SDK13a8DSfyq5mTc8ur8YhTeShY=;
        b=kBGFP9kP+1oRxHizntDXajXU9LIey9yz8xwX0QvU4K3SS5e5H/bvLqCya+yfStkpOY
         fHZZTqd8StK2NnUllyPSKsE59qW74s0VHLSJAg2+V81nR1px7BYM/s8dTnKrGigO4q+p
         sqxSfh7LLwSO9wvhJtUpDezEx8DyPmZMTV9+XHcsLF4RjTsosrPOehTgHYo3KeyQhq0Y
         QTvqI1Kz4w9joP5fou8+cxoB2fe7ejpnLQ2So4pFkDUBMkZPZPYS89B4KHomCzXzCYGK
         RO761+LNQ2DR4DwCOfyitGqoocg+Nuw37vqzd/B3lormhTr4X+/uSXOeq5SgQw5CQ5g9
         aO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732650995; x=1733255795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xQ0j+0GPxTIxCI2SDK13a8DSfyq5mTc8ur8YhTeShY=;
        b=e7TzYLOMQRQ3I1LyB0NHW46+OWJx5Y2GHcb2SilCCxEYlySC6m9gi0RBjRTkw6Zc/A
         8BYoV6oFcZeol9rtDlE+MIYX2M/mjzq1D2iT9u6JfrfFr//h4aAjfrvTuWwu+1Xv1fOU
         6qwSXe5039p+I5ruOg7Ti6ED/ujY3SaDCNWbI/VXTX0rkpFMih7kEJH6gzq2MYgPBhex
         SzKDd6kHki77ynxDFbN4nreJZ4dzvxdy10kP5OVwWwFhW3jw6fdF1jyQeOmMTivJxVGu
         cQ7a1QeOF5mrOoJQwHXoAc0dgjwCt1Z6v4VpY9O9FmRRTFbzNbsPw/gdSUlA8Cyr4lQ+
         E3pg==
X-Forwarded-Encrypted: i=1; AJvYcCUe9sHKlYCToo7LHyv7ncmppx6OiUvAOgEABmfDEwa8NvBHqaVibPGDnrbU0DIPvusbDKq8mn6fYoa75MnA@vger.kernel.org, AJvYcCWKYdQ7vkQHzcwebdAyu/6RGG7nkg56tpeMWOFPgCM+f8bUj0xOnQQfFdbLJajCilZDZQvyc03LF3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfga78UPXECYda81pxHUvmz97nhopUlxixe8PtkidYvSvb5FH7
	UMsMW4EEqVj5GC9wYt1CzNUZyg1vvtq3qlK2wYsQuk7aEsjlKxyUNlnqtoyBosJSbXOZSV8cBLC
	w7Ec8Y3ltQn8MHgGUqoZ3PLmpW2E3sA==
X-Gm-Gg: ASbGncumbhxAkCKz5aHW1GKGv4JmjApbgzLHldR6eGG8Ev8MLi7Vas+qrobiipW4jW9
	7NBYbw8FDdDjNtz5aT6P5IwATsd/4y4B+4KttQ80WT4g7sZq9VxYb8m1IcCExBSY=
X-Google-Smtp-Source: AGHT+IHRCkqCpu4EP2m8a5f0SIbZRGGOJkHFNp5nvbOOTzS3jxCURg1GTmPDbw94b45oJGKAsgVT5lQidAMPOeW4EF8=
X-Received: by 2002:a05:6512:3c82:b0:53d:edf5:1db1 with SMTP id
 2adb3069b0e04-53df00ff1e0mr184421e87.35.1732650994656; Tue, 26 Nov 2024
 11:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126195256.2441622-1-Frank.Li@nxp.com> <20241126195256.2441622-2-Frank.Li@nxp.com>
In-Reply-To: <20241126195256.2441622-2-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Nov 2024 16:56:23 -0300
Message-ID: <CAOMZO5AVyubQUpEhm-oRb8bmAH=5w2TxTnuuvoY_+HLhpnBaTw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel
 number to 4
To: Frank Li <Frank.Li@nxp.com>
Cc: jic23@kernel.org, haibo.chen@nxp.com, imx@lists.linux.dev, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 4:53=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +       chip_info =3D device_get_match_data(dev);
> +       if (!chip_info)

This NULL check is not needed.

If the code entered probe(), a compatible was matched.

