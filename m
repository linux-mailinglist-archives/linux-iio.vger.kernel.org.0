Return-Path: <linux-iio+bounces-23034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8DB2D977
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEE07A5D0E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714012DCF51;
	Wed, 20 Aug 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGU0GtSa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE825B2F4;
	Wed, 20 Aug 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684116; cv=none; b=WdazypYV+lnzSlzRow+89w/rBs1oe5qja90MTrADLeElkm7HHzHdKKims0gktkl+6CCNIzVU22Fkhp2n3VG6uu953BGIq05G/txL6lDhHXr5knwsoL4JL/Ly/UHpN/2mw3s2ulLtJ3OlwKpIxwqhhxTrt5WWi3tPe74fhsTdt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684116; c=relaxed/simple;
	bh=12AnyT+nJoWQ7Zwaii1m23uRfTezoxAQyxFRGP9xcJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMvujnHEVprflIoeztgMfAg/CHvm7/tWTXYxDT53UuOtNw9I+VyjBjA4wtpi3yoFaaxecRkKZxjpAGVnOJx8ZhFOM61GyFCpQKcJfQytq86NkA86CanVBofwoIiTbWeBusPdrKHzRsPIUjChbTqKQFg3VWBV99HxM7rq/YwlKes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGU0GtSa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb6856dfbso135654766b.1;
        Wed, 20 Aug 2025 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755684113; x=1756288913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12AnyT+nJoWQ7Zwaii1m23uRfTezoxAQyxFRGP9xcJE=;
        b=ZGU0GtSaia6c7oRbML6lADmYKU0RbnTI36/ylaz5Yn8LDvSxxMtyHvzvHKCAbhlG2k
         Bd0DYzCxbp1hpKzEziVYtqC/LTiivzsebPDNPE7jU4+1FGoC3PwgKCJffMUfzTjxfigV
         3IZtr/U54z1lbMb9I2M3lkgSDigUEXnD7wldMTlsbqKvS+UJdH3qd+JyLkpAXxNOR3em
         qM4Xnots2roarxEPaW/KF/4mc9qLt+8GdD1ugvetXvLtV6TQOAwK3CMPMkP+Xl97Fn5I
         vp7pqCB3jtEBmu/JT89cvW93XA/By7MhCy8dN2i2iZmb/dHhJPbsklvPNd54p7Npl5ng
         a17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755684113; x=1756288913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12AnyT+nJoWQ7Zwaii1m23uRfTezoxAQyxFRGP9xcJE=;
        b=BQHB8cEuGTcD3dVsGUS1vNs7B6Fqq4Nj5Eq32eQePZgKsHPYKX7L/CYNsoDlQSp38s
         7LuMx+d0H3oIS0Jkx0oZ5m/z7frAnUj7y1tkl0CT519Ui8fzHsjVANstm97Ju0G8s6oj
         pf3H+VcgsL1mUz8wbhupCQ4Lvrbqx6ycN9c5MYuXuViEEI2XN/Z9f6fGLgfb1opZ09iX
         wsPCLPSXWlu/hzl1xPQmce2c//KLPwpUKZmidN+yVsGnuCVJfld8f0JbeQtXNjcC76U3
         wFD0XggV3ROWyCHeLOQzMaJzB81rn80ZdcsVwpzQdyS+sWp+Z3jTfUmCXTq0f9JMHiqJ
         v59Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXrEA1M+9PvoIVOIR7cTE4l6iu3QSCS4ucLZFzMJkompXUqGTiuM56W/LNKhiu5NbKGCwPMdTx1hAn@vger.kernel.org, AJvYcCXFmP9/SQNDZKee8R2C1kFGdrBnxsDNTZcmby9sXPebGP2ie7VGGXvHV+oHm2solIFO9tCe9zSYs4m5@vger.kernel.org, AJvYcCXqavfaM8q87CceNYatBCvrcpW3b6vr+bgVMaAzkQoYFSwoUnRylFknLX6hNK9XT+KUYz464M7J+IVpT+6u@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPb6n7yFZZlUtcbhUnWLf8PDYVuItCzF1FdS4lP8RKCp4fuUc
	xJeR727pR23rv0CIiXZ03r0Pr9y8n5k7xVimXJrDYxWVJ0FlftpxWjTAiL+eo+d9cRJJ0tSeihd
	VBUglNp/dd8OX364EqrEsLQNf+FC41a8=
X-Gm-Gg: ASbGncvyUairRk+gBfpbUmx/UAMltvj2sD90baF0diq8Ax7Y2/5YXNShguf62as3xrA
	8V9zSaRmh0NPmQGl342qKLbRuQ/ue+E/Ax8wGk9x4JCVDKbcURMWWEKLa5DIeySewh/41AC0MH7
	b4LFtjUWJEbBTEEJsKyB0H/OlLuKCbvLumG9tF2P3ZqTuZU29ZXrINMs0fwmp8b27fdwqCgHhHz
	d3qNF6DTA==
X-Google-Smtp-Source: AGHT+IFx5Eh1kW3R5r0QFg3LtRwwSdNhv1kVoTvGNSNhlU62fSSAV7t5q9oAWFv4dZLxsmnwQxgh/Xb6Co2y3gYK8gA=
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id
 a640c23a62f3a-afdeb4fe8d9mr244918466b.31.1755684112729; Wed, 20 Aug 2025
 03:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com> <20250819-upstream-changes-v7-3-88a33aa78f6a@watter.com>
In-Reply-To: <20250819-upstream-changes-v7-3-88a33aa78f6a@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Aug 2025 13:01:16 +0300
X-Gm-Features: Ac12FXylz2Y87CBNiuwQVGcly02ciYY7x3x6JJevipMf-BQsWT2EglArAWCcHUY
Message-ID: <CAHp75VdavWbSZD9Jqp5wqZKbvWJUL0n4-g93C4e2midT5aAu6g@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] iio: mcp9600: White space and fixed width cleanup
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 2:45=E2=80=AFAM Ben Collins <bcollins@watter.com> w=
rote:
>
> Make tabs consistent for register definitions and also fix width
> to byte size.

Reviewed-by: Andy Shevchenko <abdy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

