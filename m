Return-Path: <linux-iio+bounces-18586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC3A99AE0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A83463A9F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFC61F2B99;
	Wed, 23 Apr 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSoenOwk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4A44C63;
	Wed, 23 Apr 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745444370; cv=none; b=W/fCAdePAHcVLo2yCdT4bOMM/Y5nJVCva9GjyC0iJ0wWyL1Q33U6PDWHJopg7HSMJvvrnhBRs6hif55b8EbtFbTq5x0zshZbNYzcO+bO0L4+1L+PUs5AhaCMmXhcd/b8thvdd17m0WpY1bejZE0A2W63fCsVHjj7o/2D/YHrH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745444370; c=relaxed/simple;
	bh=NrwdwZ1bicV6/EYwbG/829iZEuhX8cdxA1EAg/9J958=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgE9ny9RLAn+tSKRqeVOce3QNIGQ3zE+mXSAmYaaehCVYlpDSUwDalfR+P71BV6CVJ7pbjcwd9iSK3yTOwZDILhiYW5qesGt0FeCqEhfiv8Q1lK+O6Vb4zCcppyylZQ/Wmd3gGLWFF8ziRjbd92nNMF80uJpS26GeqCdkOX2NZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSoenOwk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2c663a3daso65737966b.2;
        Wed, 23 Apr 2025 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745444367; x=1746049167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrwdwZ1bicV6/EYwbG/829iZEuhX8cdxA1EAg/9J958=;
        b=VSoenOwkqS8yrT7EIOiWBtc+BZ1Z4dKK8RrtUp6GunrJnuiTCaFcaj/WmkdgsBzop1
         efLp8yNwnlekY1qxZ0cGtxXgL/qSmhTrfL7CGERz8tPcq1KiBKSp6FnvtSWOy3NfBLkU
         BbjT9WFgE70cNLProG4PDhqpMEpaVdEh7rd3SkSCA6YmzLW2X1Fyib8qFDDTUBjYGNAF
         EXIwqdM6VUCfN9UqMJqMT4siWO5P3toP33L+AioHgOe/LfQF/I6s+GhoF7ClkFyrv3je
         GrJcx+BhJm5BACMjdlSQTJm7dpTXHd7iutXOVZ7jVXfzndnZzAo4S/N/2M8CsCRuHEod
         sq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745444367; x=1746049167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrwdwZ1bicV6/EYwbG/829iZEuhX8cdxA1EAg/9J958=;
        b=LBM3uo1+Lu4I7HJFPRfr0siyVJDUQ3mq+xhBDnWxm0uF4ZIEhBS6BBV8RBDwXFjRuy
         vLN4pZYUSxj/Cg6iZgc/W1J9cgEznChG2mf9fcuPPjNQKcG+q6y25v0d+dCXAbqqmiov
         koaeb8Qn0tA0cD1cPbWUafovdKvam1xOInhuaEpgkVNYBo1lMHjz2ib+rRFAd4sYMPWk
         g2bK2kGD9XvROeg3e3EJgR717jXR+qaACbAN+FK9ZFr6nPcz2N49iH+Mg1r3pYcQkbCk
         PTGbQ4STYrybI/Ai5t6nfM4O1x9hTMPLI34cNpNAM9CZJfh5i2U1Dxc4l5vF60+/If9U
         7cew==
X-Forwarded-Encrypted: i=1; AJvYcCUxWuutdaT1LyKVS/6KOieHVt1gGQLJUglYBAq+pdAehvppEDxL5NBwQFyKgEaOx8kvFKfcUO2KRf6m@vger.kernel.org, AJvYcCW/ZQNysDkF9sGI7ktkGtyLIC/V991CyIiH3dSa/iuxM68qU0XjQFN4PADbelI7rYo2Ywx6AbMEJEUz@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRHLF85iivPGWna8zN3cALvgJNY67SK0IgXeS7GXCI6TRtKJK
	ueBzJzTIXrb5x7hRPLpIqq022hZkaIfEJauURUlupYLEuN6gFtRs/JnWEz/Cct01Mso53RXQrdy
	50E2Viu2mSVWFhT5TQ0jkTjsMg2s=
X-Gm-Gg: ASbGncviFqZd73M+u9IyBV/4QboQWOai3yEpN2PkrUA1Kh3f+r1vkC04PsEmVSAn4+y
	xIlFlCJSTfUZuwHfSsp6pDsQYH7gr3Uft1N3kToth9VVmdXYUCuY0csHO0DdUvVbQq95DD85dCP
	1b9+ReXrDVDK5lD7cv4imlvQ==
X-Google-Smtp-Source: AGHT+IEEAct7ecsOcBw1IX6FDWQfSW1V6NOyNdQ2iXmXx5bKLO12E2pjRs24wdhZkzEcZpHLORAPhdCXiBCRki/07IM=
X-Received: by 2002:a17:906:794e:b0:ac3:5c8e:d3f5 with SMTP id
 a640c23a62f3a-ace572894f3mr38471066b.27.1745444366416; Wed, 23 Apr 2025
 14:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423194100.53934-1-gye976@gmail.com> <20250423194100.53934-4-gye976@gmail.com>
In-Reply-To: <20250423194100.53934-4-gye976@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 24 Apr 2025 00:38:50 +0300
X-Gm-Features: ATxdqUGNZiYHxXwzI2z5QaT7M3A_zYGYopJe6QBkLr56oxnU1m-9sIVc1vKqRSc
Message-ID: <CAHp75VdHnBQyGFPLwpiZZdGcuwhyMM0Yfnv=2+nwr1Ma+1T9JQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iio: chemical: Add support for Winsen MHZ19B CO2 sensor
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 10:41=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> w=
rote:
>
> Add support for Winsen MHZ19B CO2 sensor.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

