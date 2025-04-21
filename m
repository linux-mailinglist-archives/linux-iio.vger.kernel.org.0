Return-Path: <linux-iio+bounces-18452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45514A95212
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C25D172ED0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40A266B54;
	Mon, 21 Apr 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV5uW8zU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE5261372;
	Mon, 21 Apr 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243738; cv=none; b=WkmHQwiVqW5zYNoqc7SKbqi7cCjyMc97K9dbPX6WwY7hJhCY9YGsKn+cRuhEYq2T53Dbjb0e01eJLmdyQGAnyPfRNYEY5o9EnKdSEexZ7JA8B1NXaXCh7aCQiOCkD1xRGzMQgTsW+bdvQdZh7hw2tsln9VDzMcnvuIhraAfsy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243738; c=relaxed/simple;
	bh=ZKEn9aBGgxZBwMzz1mJ0Df0kwnfP6ieCJou/s/mq3KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSBRKx5AyQuaV4gmf3SOJLvvvewWOsi+emwwwQAh4WTEDIg6PQDTfxHyCoDMJkK+Csbj7HNtKnMKoK34L/NHFMolZWPkF9ZVgpuFf4ibPDby3tkQFIhlhKlEFOQQQvTBw8+DIDhFGuJH2MHR/l4qxLtsztXhLdi/AAqYCQjLQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV5uW8zU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47690a4ec97so42863411cf.2;
        Mon, 21 Apr 2025 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243735; x=1745848535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKEn9aBGgxZBwMzz1mJ0Df0kwnfP6ieCJou/s/mq3KQ=;
        b=HV5uW8zUEZvnD1s/yc9Fvn+B5wpGPyAgq3OL7lqa2xXB/bcHscqVkHSr00oM05Q4cP
         Ua3wli0U68lDja2bFze2MlumHwTSWGYjZORNKUehhzagFirkIGNvJTPEXqz0WH7xSAIJ
         wI2XIClXbsCu3KqBr38Fnv+ibSkDtZCnLIhGismUAzbRNrlowLpxsqs/cSddT+AFux+M
         0+j7UGpVfybV1+abUE5VC5q/G1X6ccDVK9oo/RXfJnlBfyH9lOH6szGT0W9RQa0kr5yv
         cBfHCJ6OrWwGdivflxIk4++zcWF/vO+im3DGTIrpE3EeeiWwoXw9rUJe1nVD69XM9waS
         IkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243735; x=1745848535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKEn9aBGgxZBwMzz1mJ0Df0kwnfP6ieCJou/s/mq3KQ=;
        b=cbl08B9R/pp1z5zZcqJWJFXsbOorE5gApkfUf/VoDu9+RLL/+n4rpE8QlvufX3q0qG
         DaQLzSkJ8R9OkHa3M3ougmcsvA5r0Yw5UURGDeSbOk4MPRTLD56CKHTnjML0LSb6yCHv
         UScmk0nSzSJnrzJHST2sbGRENy12g+/0GNN6VJw65XdVdy2AASr2UHXRx7qmgrOg9P5e
         DGLqPq5ETJ4LtFJ/FOHBV1UgovFkJOY1+uhPPn1YAj4GnBG9yEkZgNZ8/Zi6Osu5uY1a
         8eYk/hTGCvUWAvpmF4KDwlsCzgCLx9Kfluue9CHlKck5IyXw0kcvl5hJvaRQH+P3s11u
         JSDg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ywEvKCkbdhN0XdiZp7zoG25r3gZ5MK5wYcFWcBHrymx20YyF65zgqMLvw2Qvmi4h+D9RwVjZCy8=@vger.kernel.org, AJvYcCVjAmwtL+xuTCSybmSTt9OFPRbsapQJPsA60VvMmpdINg0iDiJeoeluJlSzA20z3d5jfK6V9ohi@vger.kernel.org, AJvYcCW/gc4EjAifUk+YDwqtlZhRYZ7tL3Pct5eGHkT9Uh4l3G8Sjryd610peFpLlENkLKPZwNZV6EcdXANmvrZ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zaiINkpx+OtG6I3aIWn7fk5P+L3dP4A/9fEePuOVe6sAU5nI
	v2wxIX1A2OiDZfPjtzbm+Z1ErZZx1ZfjnQHH/t3BfFrcCnCkbdAEe8hBmbfjATrsFGRNLtWrXKD
	dGAXr6v0ftwwjsqUZjeQ8lQfEo4BY94jarzg=
X-Gm-Gg: ASbGncuzFmIcIsUEAHidbOXnTSvaWaWfv3NZwOcgs7GBdpgjoKomqjdntiRpXe++GM4
	s35WIwMKoKy8R1OgU05mK2hPTU8c2J0sz23Ha+Xo9l/v4CEw/fcLAdSflZ3e1nJw4UxOElNcWvC
	XDa1ZqRo00xPGXUd3hA448xva7L9Eqp4Xwz301pqSYNGjsnpOv2WTgiA==
X-Google-Smtp-Source: AGHT+IGe3nS55q4799S3M9i8763/VBcBZkGtpasPvAPLMKmDSQ8P4wPK3n7/shzb2OhfTHLX3O3iRpkuRFOnTaqRN3k=
X-Received: by 2002:ac8:7f13:0:b0:476:8825:99bf with SMTP id
 d75a77b69052e-47aec3cba27mr234780651cf.27.1745243735417; Mon, 21 Apr 2025
 06:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421124915.32a18d36@jic23-huawei> <20250421131539.912966-1-gshahrouzi@gmail.com>
 <aAZNCEUejrTgy_yZ@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAZNCEUejrTgy_yZ@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:55:24 -0400
X-Gm-Features: ATxdqUEyCdkkjmlQnLpYD0QbwbveqWM8VEc031aMZldztG8lgKbjxR4Xs8GWJg4
Message-ID: <CAKUZ0zLEacGg5cD4wGmFz80e4FQ9A=JsVyrzGAHkKEeOT=CU2A@mail.gmail.com>
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 9:48=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/21, Gabriel Shahrouzi wrote:
> > The inclinometer channels were previously defined with 14 realbits.
> > However, the ADIS16201 datasheet states the resolution for these output
> > channels is 12 bits (Page 14, text description; Page 15, table 7).
> >
> > Correct the realbits value to 12 to accurately reflect the hardware.
> >
> > Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Should I have included the reviewed-by tag on the latest patch sent in
this thread since there were no changes to the code?

