Return-Path: <linux-iio+bounces-5261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537128CE462
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046941F21B96
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAAE8592F;
	Fri, 24 May 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2rcn///"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FA328B6;
	Fri, 24 May 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547662; cv=none; b=uVedLFkp7N/aZJtGeU26GZCXf39xRR7XKsOoFPF7xC7IIXXRu2wXxqaH6Ux4hvGCIwKVCShVwDgUnk8RCrRmuzF8EnIIDkK3vrzWWBHpiOQkXALJ960TUY/BKHi6dfxaFiHZd/fHTpxybENLbPSytu9D5w/SJBILccpZ9uV043s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547662; c=relaxed/simple;
	bh=Cn7ewNXIF644KtlU+Ek21a4zvbcO07e24R37rH614Dg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eeJKE8rRI5Rfmtu3OOxCzO8Jfa/TcbHOXXeQVscUVqjO2QxDU3nT/T3jig9yB5GD119kNSOAZO7msvzfZ1mzzWVOsy6mKKkkaqkcJh6AqgWWPNwfkgQWvArGouPl+DlDVZ5Lf1dpxErJoeW3KnID2lrz5P1J0MmpjXvupJrbSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2rcn///; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354e0d4db6cso1780730f8f.0;
        Fri, 24 May 2024 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716547659; x=1717152459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn7ewNXIF644KtlU+Ek21a4zvbcO07e24R37rH614Dg=;
        b=h2rcn///10w6n9cGvL2KZSCbW3q8itQ84g5/wkc72Tl/1fJolFGocTItcClphx18vp
         RqVM7qZCR06KRVyax1/+i+14jluNAsX24JenVihoN5iB1Y+9GuBnvQAM+7RVAr7Q1FV1
         pC+2OV6OYCeHtKKsgs8sbFc+W9CH2lxHg8I260GUvfLp2Xu7Jaun/Wg5p4Y8eWg/nfZM
         US0O3/zwUwRpz+d/v1W3k4UGJ5tecbm1nV/TMTm8xpRqrqWzx6DDMJC0cO7Ct+bwSfwe
         xnhQmVw4APR0DeD8jvJ0bbfFVzpyk2u+AeWGfjdEWDdlqZ7VinpNWHzmPB4//Df98lRa
         L9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716547659; x=1717152459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cn7ewNXIF644KtlU+Ek21a4zvbcO07e24R37rH614Dg=;
        b=VB2MHL3wbxsunzsWup+cTEdFeh4maB3n/sx7MmUVJbmlqZQBPVV/uMgcVAUUY55p5t
         Ri6Q5dY16klYEZwLvC3nahpNKJ2NfV7QiGB16WMyYEVreH0jnxbbHbRnGi2PMW2LUWpW
         9/uVUClXrxPHCMhXICCPGxaQqm/0rOEeVEHvBog7AlkaQXZc41G2KjbFFo1tjXLDjph4
         T0tnEJsaoklu/bnawAU84FDHA9PwIOdj/5d6rHdIkcOcNBiVTtkvkRgdzgfCxvSWq7J1
         dHPtTrgGc6/eLPE+VfjHZa7LCUJnzQlIp4hJmvIsAnYs2SCBlvu/wIap/ui/9BfCLXlS
         y47g==
X-Forwarded-Encrypted: i=1; AJvYcCWJUJfRlqyUF670j0ZHh0U/IDT0ZawVjBgN7AidoBrkzrui82ibknm8fDIDZFvLk0E5k7jWwUTsWXPRJVbsh5Zxtf5pezWWPdb3rythPppbByupYDN55UdW544HeSMVYIiajbKd8jPX3qvMSAxA1enOZ/4ro2j8P5mqPDEOioqMy3AaUA==
X-Gm-Message-State: AOJu0YxKSRaE0JFADQVu57Uw5pkJdMz5yIQF84YvqUwNYBT1sFehyHhT
	9gZXNtallgIH5TAQj0f47Sdoh8v2Rynw8ntO+8R6sPbsQ5ZkTLKM
X-Google-Smtp-Source: AGHT+IHSshkfT1uIQWOnACVv/tDpADh+aIudiggPQs3RFyGGLrx+yTBY87WFXQ4PSYNZ8Sm7sOWKRw==
X-Received: by 2002:a05:6000:11cf:b0:351:debf:a39e with SMTP id ffacd0b85a97d-354f757d1a5mr4479651f8f.27.1716547658868;
        Fri, 24 May 2024 03:47:38 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fadd72sm49999255e9.31.2024.05.24.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:47:38 -0700 (PDT)
Message-ID: <4ccfe084339360695edb5ae774a3bc67b1781c95.camel@gmail.com>
Subject: Re: [PATCH v4 08/10] iio: imu: adis16475: Re-define ADIS16475_DATA
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:47:38 +0200
In-Reply-To: <20240524090030.336427-9-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	 <20240524090030.336427-9-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> Re-define ADIS16475_DATA such that it takes _has_fifo as parameter.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

I may be missing something but do we actually need to patches redefining th=
e macro?
If I'm not missing nothing the first patch is only relevant for the new ADI=
S devices
which are added in patch 10. So maybe squash both patches changing the macr=
o.

- Nuno S=C3=A1



