Return-Path: <linux-iio+bounces-12756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3629DAF1F
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 22:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F54E1666F3
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE94191F75;
	Wed, 27 Nov 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcbgURYx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D83F9DD;
	Wed, 27 Nov 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744472; cv=none; b=K5Om75nzapjirA4GcvnaxMWjlvyejYpt4IPhQ3q7VW91xcYyeGRQ4NyNKIQNBkAcaAgfB13gOzeQn1fuoTn15OstvTiw4ZUr0bLxfyVDtdHep1VE2uM76OsZOu9tkdYjaowEBMRXwpwrs37cRCuKQQM0YWyZB6dKSjInm03du44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744472; c=relaxed/simple;
	bh=YuGy9ZCRnqsUhscscY23DwGwV75BCtHvzuixxPPh8+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ma0yFakpFxdwR9OKIngDrOrcsRsyhB5/I9rW8xPnr5N1OGwIlO3hK8XTw0MahZP5TM+kws2I2V+WYoIddbDuEyqMhLOp0RyewaBXxn9xBn5PkPfAIGw0WIEX6Ja9XLXndCc7vxj8YYRj2kL0pHYimYL7zK4S3Y00qcbqizzpEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcbgURYx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724f41d550cso154105b3a.2;
        Wed, 27 Nov 2024 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732744470; x=1733349270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuGy9ZCRnqsUhscscY23DwGwV75BCtHvzuixxPPh8+A=;
        b=IcbgURYxbO4Ld+XddxiX0T7nkCK1OINvH6t/bRRNYtkazfpc1P3cn6b45s70xSoOzD
         lAO1PLYKvfZgCQkWNK33DM4w4tUPf5eZC39lVSnqaaeeLImCelYMBLTzKXEd2jBpYfbG
         59oVK3rlJQHK35ocZOye8HevDdOlksmLrp/fAc93MeOjOta7Twkp24K29Yieap+k6XwE
         DS094K3oVK00MSSbLEpi+WbMI879DQNAGVOoWExqBeZ4k4DyV7K30mK7Z0uEy0F+qvlk
         oJ/IcMvnkmnacSXJNx71UtiX6KTwBSzxaIRM7jUb1PdZJbmaWlK/7qKKx1YoQbaupla+
         Q95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732744470; x=1733349270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuGy9ZCRnqsUhscscY23DwGwV75BCtHvzuixxPPh8+A=;
        b=pEnt/lTOxo8C97hqNvrJd5RHxM2xgQW6JDXRgmvsQ5W3F4sNjVDg+AQj7rOkehWmPf
         DfL5SxKz2XdCZhPV55eSX5Eirta2WJYdqtrEtUWfuCMl3hhsXfoQkDBniXYOuUuMEC0u
         EJ/CVQ7urpurPG3hADR74VaAkHH8bhGvO1G3o3OH9FAbX5IUFm4pDrImUZZvLBR9CrR8
         gLPaNuniUAAJhcZdg4E5IAoHc3DyY5BlGFU6fyAJtyGYKKCLKOuRtBBdVLRCC0APoe+1
         uSz+HZtYFM6jsGBzff84B2xVjWBLyCHky0fBovoGKguvF7ploiZ2u3/FiTVFeB1Dce+d
         bk8g==
X-Forwarded-Encrypted: i=1; AJvYcCULcpRH+S5iPZ3/GVWuNgTLMXxW3R3KT45Y3Tkl2MH0+g4wlKjFx1lWrBemdTVD4Nk1rmPWlIQXUtoddHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2U2+mXTdJOsTl11t454236O3WGs+sKPcTxaqQ2N2OowSExtJ
	0p/h84lKYPQbP7d2TaT4FX2lSqr0xCGRwhukFGOwEAm4BDe0Wt5h
X-Gm-Gg: ASbGncsc7dP6WFPaZ8XzqgF9Jsk/IpAzqaWo6DVZ7fa+8mB3WCvHWj22W7XNMR7NxzU
	UXR6ZF2S5dK98JVjhW0v1DyquOWy8RFBYtTdCHMiFYOpDZXXMgCoOKcr2MK8KOp/JUTV9N/F6Tc
	3fGtzh/17agWWwmG0f49QPumvgn7QHgvYd+YxAxLbHcukTLpzMF9wmxXcbpW6PfOIIWfZQcUqiR
	+Rs4M1kL2t45MnPcCZo+57kWgR4Acw2CXDeObYxAQbrbYv3OI/uhm833UUz73iw4qoU/OA=
X-Google-Smtp-Source: AGHT+IG6amnJVHYBw/Ql+QzwBliI5iw/nwAu3MF07EIkvLED7RS2I/HLTFou+WrG3va/EtlTbyOpEA==
X-Received: by 2002:a05:6a00:230b:b0:724:5d26:d904 with SMTP id d2e1a72fcca58-7253014341cmr5722470b3a.18.1732744470447;
        Wed, 27 Nov 2024 13:54:30 -0800 (PST)
Received: from localhost.localdomain ([177.10.10.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725418482a7sm36277b3a.190.2024.11.27.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:54:30 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: david@lechnology.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.v.volkmer@gmail.com,
	wbg@kernel.org
Subject: Re: [PATCH] Add COUNTER_FUNCTION_DISABLE to the counter API
Date: Wed, 27 Nov 2024 18:54:04 -0300
Message-Id: <20241127215404.915-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c67e095c-3fba-44df-950f-b014ce27eb0f@lechnology.com>
References: <c67e095c-3fba-44df-950f-b014ce27eb0f@lechnology.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/25/24 11:36 AM, David Lechner wrote:=0D
> How does this work without an additional patch to modify the TI eQEP=0D
> counter driver to handle this new enum value? For example, I would=0D
> expect that this enum value would be added to ti_eqep_position_functions=
=0D
> and case statements added in ti_eqep_function_read(),=0D
> ti_eqep_function_write() and ti_eqep_action_read() to handle the new=0D
> option.=0D
=0D
Hi, David!=0D
=0D
Yes, the intention is to have a second path where the eQEP driver handles =
=0D
this within these file operations functions.=0D
=0D
Best regards=

