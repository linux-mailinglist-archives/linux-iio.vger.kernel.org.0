Return-Path: <linux-iio+bounces-26254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97DC6130E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 12:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384944E3FB7
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C8229D266;
	Sun, 16 Nov 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqazLosp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE04283FEA
	for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763291141; cv=none; b=q3dkkXxyTiMztQrSfVMAw5sWVJRWE/3Rd0BZEhYSr7y3NakvenHJdGb7FC0NFvWAKOjNccLjvNcetam4DuqyZACQ7OpwejUJQc+57Vl4kgppoQ6iXkCNWvpLz/dGC2iY5JqDGzXlr79vVIVeXSm388uDIRX9r/jYsFu2AtKs9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763291141; c=relaxed/simple;
	bh=Qmhsp5iqMCUF7giQN0/lXYSuwESzZPm3nOLMmlIi4dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lP8CERBW8CuYgCyopwzCdhIh3IwKVTmb9SL/VU5Vs81qpeUq9WYLSJsa7XCCkedKHF4p+wV7zUhH7POyE1c2O4Vrf76Qjs7u1A2aDywatk+5zbx9ZK9jDL5aZ+MQsIg1zp/5eU1ZWZfpA/2aRNAu2GPy0wHMHTTYSoR1mjqytcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqazLosp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73875aa527so105788166b.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763291138; x=1763895938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmhsp5iqMCUF7giQN0/lXYSuwESzZPm3nOLMmlIi4dc=;
        b=GqazLospGARzhycSsibdlAHW1HBmYI18f432i8zRLfj96O+lShsSyFNDMwOxKJeER4
         9/EzhGAsMf2a2QfANCjgkQNGuja+yjPy+5efGlNpi+96W1dP+WOh5PPXKJhQFTSOCVQ3
         7+oHqrCJwoPyCwXy7HZmyD//0GttHNg8nIWSlUqPZQyT9i75/nWhagufVJV6nDaPVrL7
         bojuq4O8v7h93kuNmnLv/onI5pSJg6Cyk0W72E17AycaHxRzi5rDiNJMzmr/IpLSn/El
         Hr1uaVXbZ3zGL6BeuenMISyPso/z9J1Gu595nW+c3MWrpOfSNt/n8foJl8MIeLImIOVv
         OAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763291138; x=1763895938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qmhsp5iqMCUF7giQN0/lXYSuwESzZPm3nOLMmlIi4dc=;
        b=Y6Lo/YxOv8JHvizWYH762sgmO4vWDNj9jZHpDZJzZv2Ryi1/YYo5BCLO1yctnKP5xD
         jZHMD/8rPN7AOKtEz73vC2xhmvmcVe7QScQsPla5pZ7BeFPPPjok2govdUfq6cDT5LTZ
         JGWG62y7GsfokLeCsxGYKIpFJZMrERHpHBs+qESsa4Sfwn4VSPZFhKWqOtABh+Uu5QIh
         qO6DAYVGb4WELAoduWmiIdwe5QIQltLlGoHkZjqRXldd9RmunwyaB7iIxVYlzIOxkt22
         2Xt+HBeBe2xh8a+fn2c4ksuuls1HbHKeMRPrPoQgJtp6eXb6+7rn5ctN+XIf749y+hKD
         pLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwUa2Hx/fZgxtY2VzgN3hO9vcNzlHnylVlbWD9kuS1hNdW6m8BXTxUMPHClNdzjfLVtyJKki84WVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+p+JzMYqn1TTQSCkbF88peheZmB9n1kcCQ2UO5WTjphFZ0Xy
	UK7qe4XeEqyfhndGw5M9u1GgroTnlCdlslHWOWZP8u93D4+GSbi1rgbO0c9DQqHGtAqNIxDbhqw
	+B5bCpvrbGNVUiOwAm96eDEwUKNaAGh8=
X-Gm-Gg: ASbGncvugMZ6isiht+ZlwTZ9tBUlUONQXKh1pwweT05Cc3qT9jU8wqXxt7w1PMCdgkr
	44bhxoZ3imQr/I8YNoh+kzNvMe+zKH6Y/txI3aST07AKZXmhHAMBLrOFMfNJpnNvHcknyl9OoAC
	oUvR/uL9hP0141YQmtzDUE/HdFJTDPvZguBvi7PUkJEG2BS+US82cHV7ifyiOcZZ7tVpUB6FPYT
	SzXjDloUqU9pb81UvSynXAltUogvGhm4D6urFDTq17ljXUozr02eYUJbz6XnMb73AQlcwpnUMcP
	xJAuCI0tZJdywAv1E8g+mKLPSkQ8cEA3REPUPrQw3L5457/OfbUoAK8u2i0=
X-Google-Smtp-Source: AGHT+IFkXZnSjBpui6lLjYFNrvlMLVwmcwc8IKwjCC3Uo1dYLLp/yRKXn4uu7zSsATPXYEs6GiRqnFrWw5nSQwjMtCw=
X-Received: by 2002:a17:907:749:b0:b72:3765:eda9 with SMTP id
 a640c23a62f3a-b736796a3ffmr966214466b.60.1763291138045; Sun, 16 Nov 2025
 03:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116-61849-3277029@bhairav-test.ee.iitb.ac.in>
In-Reply-To: <20251116-61849-3277029@bhairav-test.ee.iitb.ac.in>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 16 Nov 2025 13:05:01 +0200
X-Gm-Features: AWmQ_bndW3tSwLpsoyIbUvrNfDnHK_68tFNLKG2yV_xtzuDFDn0arAlqqDGPHlo
Message-ID: <CAHp75VcHQQeZRyALNBdojPFczjSD7v-=+ogVBzb97xbnYts8kA@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: Arrange Makefile alphabetically
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 8:25=E2=80=AFAM Akhilesh Patil <akhilesh@ee.iitb.ac=
.in> wrote:
>
> Fix hp206c and st_pressure_* entries in pressure Makefiles to follow
> alphabetical order as per guideline mentioned in iio/pressure/Makefile.

No objections from me,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

