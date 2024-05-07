Return-Path: <linux-iio+bounces-4870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569A8BEFA2
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 00:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504122823D5
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 22:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49BA14B975;
	Tue,  7 May 2024 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uwC9pMGa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDC54BDE
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119799; cv=none; b=egTHEF3WCGt4abguP+i4AngnCDhdcGvR9QV2522w3vvusicrKSGMBRfmb314/+y2ncXdBPW/VOb/oYx/bUaf5S4LTw5S58rNLRJkWeETPPl7d6NX/5h2kOoyPd9AlWwQbO+8a33UZQDh7qO7F/wyix916KnYFbiQPYg4+qeb524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119799; c=relaxed/simple;
	bh=rz4ZDYMxudbdC8GSlW3kEF1CvatRJGfB9hkcnF0t+1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3sFnkZubG9luKVxG0Es3Ps3OX/M6GDxyShnKt72/1LN/lLqDAEIecHvHUnka5NOaqabA6DGNUDOCGSGS2/qIEwZDQf7EYsAUo+IfHjCx4fxnikcCzSbA8WWuPQePht1omAqhHYwuHIPJYC0/WnwTi3sowE4TyUtw//Ili0hh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uwC9pMGa; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so48541001fa.0
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715119796; x=1715724596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac4p6+1ybm5UDnW5YmcAzBGvGhVt4yypjSgPS4Q8TxY=;
        b=uwC9pMGaMq0L8MdFA5rJGAmVMpaxa1weap19mgiiNV/XuGe1bh7J2d8/kULKKZHC2a
         q2u55Zqq3B24kRw3Y4C7rTPjnqMKcX+VaBeORVKHEWrUqxH3bE5QLP6q6JRon/UuJLKG
         nB7xto/6VdpCPZWQq8FnFJPdr8QHgwSWbXd7ah2OxGhilOxhKNvRBV12SjDK/4WcHx+N
         MbFr/geLvWsVSsGOtwwId7Uu9v8OYm2al2uwBd9n6UiRAEIb5wdiDlz4cu+KH12TWwC4
         D8SiZzOzH20MHu+ahQ8JKTci+8z1tUOTskH7T/r/sBogukghiEz8GNLtV3z08JP+TeCb
         l1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715119796; x=1715724596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac4p6+1ybm5UDnW5YmcAzBGvGhVt4yypjSgPS4Q8TxY=;
        b=M++BkxMMYFHJPjGpHDRJC7s6BAG8/VVz2byXi35mmLBGz0wsDRteJZGlY2st9+JPPP
         gdCrVYT5y51AjPBxKfZOin+eAaRABy6QMcE1MsyLIb7PMSdXJbG02eGfpWpTxV+afN+o
         GO5C32gVyS7QNCEPn5U22TRXBqjTLjK5hGKeg3T9IlcTbp9+xbaFMsi7l6WRcf2/nV7o
         2wWT674K2nQhzlpiuZZYiImQzo7+qJN4ZxjFjDAGUwf59kT0uojCqqb8FWS7KD689Wpd
         HLo124UXEN/MX7lgSqkrt9cXtYzGSDoP5L5WGIP6vqHsb89Nm7UfDkND5PfVloQe34Lt
         UYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhiEBNd5CZYvaL4Oy0rCmrUZmZggYXi9iSvZmUpzThqWGS28uaR90hrshg4w/kdsjJZ0OansY0XRBnOQZZry3Fj42qRkeTD9Sl
X-Gm-Message-State: AOJu0YwQsoVPDcu/EI8mkIuYAhHWutUqXUYXX5crDU5+NrABR7dg/anU
	uIuhRBRcDyQNNsvK6yUGGYDbDD4zk8n7lOHxda4Qn+dizlw5WwXoSZ3PSJ6zzGmjVcE2hBmLymQ
	CsVqYh0RRKig/snYZaleaBviuCtFPx6TdjrhsAw==
X-Google-Smtp-Source: AGHT+IGd4OLJ8TyONdPhu6+NfNprGQFNyY6nogkdByV/4wLX6NhgqopTXlvMPXz5HdHB96Qr6UROFsAkbdh+80WHfwA=
X-Received: by 2002:a2e:3004:0:b0:2d6:ff04:200f with SMTP id
 38308e7fff4ca-2e4476af8e9mr4709961fa.33.1715119796124; Tue, 07 May 2024
 15:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
In-Reply-To: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 7 May 2024 17:09:45 -0500
Message-ID: <CAMknhBEdcg3O9A5rDPkPSgpshn_F2CTRdNR1FjYud3i0F-VOtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for bosch bmi120
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Danila Tikhonov <danila@jiaxyga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:00=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trab=
arni@gmail.com> wrote:
>
> Add support for bosch bmi120.
> BMI120 is an energy-efficient version of BMI160. Despite having a differe=
nt
> CHIPID value, this variant seems to be fully compatible with BMI160.
> It could be find in many phones like xiaomi-vince or xiaomi-tissot.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> ---
> Changes in v2:
> - Add bosch,bmi120 as a fallback compatible.
> - Remove error path if chipid is not found.
> - Link to v1: https://lore.kernel.org/r/20240504-bmi120-v1-0-478470a85058=
@gmail.com
>
> ---
> Danila Tikhonov (2):
>       iio: imu: bmi160: add support for bmi120
>       dt-bindings: iio: imu: bmi160: add bmi120
>

Preferably, the DT bindings patch should go first in the series before
the code that use it (makes it easier for reviewers to read it in
right order).

