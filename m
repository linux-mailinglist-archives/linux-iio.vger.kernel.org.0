Return-Path: <linux-iio+bounces-28000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC4D3B62C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F0630695E0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F2D38B7BD;
	Mon, 19 Jan 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSzyutHn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE024BD03
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848499; cv=pass; b=lYOdUJ6EEfkVgIvmf+U1pbR4OdLg5ojila25M8t+EDUFGF5JFDaWxeyP3QQymGnrw4KhQdswBl6hfTRoE/Bo92MpxJ0jayMW8AAmaYg2jQjNbZCfQhy9YJNGG/2Ion+HVsKVhaq+sT/j0Dw4w06cImybW8szFUp0OIMjIpaNRUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848499; c=relaxed/simple;
	bh=ExbFjPG0dS0jP66vrH1hc+CLwHoyOOPLCoLR75xK5zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNiSiETGXqX5DxK+PeYXItMI5pEIXLrbOq4hYzFhijcF7xKO94AQvo7GlJx00XA/uMLYLzSnBbMxs4jHomHh5a+aVZpteVDb+qL2I6H8F1haWyuRpsExAF81WI7NqrVSIiW4dpG7eq0gBuTj1IK8EJbUDhkjm0/Bj1zUVAX6xTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSzyutHn; arc=pass smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b870cbd1e52so670756866b.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768848496; cv=none;
        d=google.com; s=arc-20240605;
        b=aeeEYDWLEEXznbkLrp5oAQPGGLMYJ374ynI5aYCVlpNu4IbDuM+frWxoH0dTFxDRjs
         ns91j1NkYMEUH2U2v8D8NNgLgontw9YkalINcC8o6D4eIab/5EncdpPv+CZTl79MIhRd
         fCA/o6h8CTlO1IgE7Vg8XSg2SnFrYVVN9w+ltjByLY+B+fusb/jhatkWwD0jyDIivisp
         FFWm+l8wgGim/NDyr+ZRoDJ+faKuBeOF9++u/s699RghwvFgG5UAdx6GiUd3S9P7u6cM
         Ju7YqWBMyMO9cUbi+1ogyz8KwGQxswCNBDqAr+lhaeX6sj56U6w61fakGCChdSCCOE4B
         GHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x4sp7Tmd4lgm/liXtP7pzQ1s1etRkOAjSDMDJsTb7AM=;
        fh=uFmdJRpODhXyFCIU8v7b5nEDlzzB49ylJfhVHHVSyq8=;
        b=Y0AFk71EbrldWzqYdOeePyQEzV21kyuoLyXtPKzRcd1T1JytSzANMRigypUY9rAINK
         BZw6GHzSnYXZZTVt9vpGfZujvKzxb/lwatyMoNRCOr4q8B/PnTvSdvZ/D9CJcTObZdOk
         cIvgNI2ra6KXVdslyE0WXb/8NOFJd9WIlUbLl4c8XgS1L5qIvGZthRKLy/eQ6+zVczLv
         TuT384D4J0QK/lJKwuSh+CDEpTOiuNi8lOpyAO2JEd43zyFf3HWNtZgTwMXMnxgxj2Hd
         AK/sWcYj//MiiD2ryH+4keb4fg8wrLaiIvdScb+J/iylFQDR2N6RbZOllPBTGA9NueL6
         7XFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768848496; x=1769453296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x4sp7Tmd4lgm/liXtP7pzQ1s1etRkOAjSDMDJsTb7AM=;
        b=jSzyutHnYEs5rZrBN9oTiDHyEfLndgTZ6tKJqViqbqfiIwvAYQCsLd/dy6/QTyouxr
         ho+MfzayThD29qRdfQly7A7hCwvcf/6Sfj7uDuNMufgiFcnSUCpiQNwH43vC2ZuVL7Ei
         lJY2CjP2dkXhkze4xZNbu1jvIbgSh/64mmPgjmGyDZ0WBi2X2AjLtLIki0+53QHuGHci
         IeV9dYn62+ssSO2JOvvEzLo17j+GA8904A3efm4e1RZ1PQuqzDPyJGLQsSZURUm9x+gA
         q9xGY/w2z9zsNYNmo7BnLzi8eR2qBCfekGLIesMl1GCCyfn86YWTGBLQ71mwmfeX6O9B
         sVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768848496; x=1769453296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4sp7Tmd4lgm/liXtP7pzQ1s1etRkOAjSDMDJsTb7AM=;
        b=eoW2K3HfDYwcZE9FbGQQTFf0aQHGOV3++1aADa3STM/czI3MxVXUuxGWFB9xOJkvDa
         C+W0cAUDgdaf6XYJ346IqT+7tAKgZCNN0dWhl8s+1XkLgn+YMydfC5u1CJhGwyq5EOZ2
         zBRgzNobUuHy9MM1uTrXtw8Anjt4gcyNu6Zf54kHBpqG8Qx1cdnaZPAzhgo5xrfnWQTe
         DeZX3Mx46m+VX1pKh0hS8Zh9utfjb4xGrWgM7V7Z7gKct3XOvzNpO05pME4E9lbvTcG7
         o/oqJOe/mEN71jIvIbJ4HOH5Bsu+jBJ3OMUeUMVVEoij58fvYyIlfDqS6L4vGBYQ/HuG
         nQhw==
X-Forwarded-Encrypted: i=1; AJvYcCV0SCGHaIRWbMjyMEstDNWhO9VTRuSflf2oLI+zmQAIJ85I1iQhTvcTjipZgPqQfa7WW0mB3kxrtXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQCLCD68rrp4FqpKOp9UhiArZLdEklJeeNSYHpDiOHryV4QJf
	5L2GbVmQvKCSzKjDZmIv4DGTF9pY9Y/0rIqBPVeqdjdiJN7/DBGe+kcmKoVCo4i4PpFUKr8EDnv
	gZAkPNSsaVgXYqYb0PWBvcmcdl5M96CQ=
X-Gm-Gg: AY/fxX5d4k1gTUPChIPEdqetsJ9+WQK3H2DM0oWMmj2gK5r7Z0/pVajFZdBOEfnTtqI
	X597PcS/aetP4/Oh+jAZE9ZXl2ktUZKIgUGy2sxd6vt5JHzGTiPmv3XbhVf67c0Zzb/9cgQOp9A
	1dbKBIbakku5VKpZSx04P4jyXctjrfKwFw8q1lajUwWsKzxKb0ciHzhoZ8FCfHH+lQfRv8ODKgt
	xn0FskGXUYu2ND+/cvHX1JT5RGJbwuliMwTDKKXxgBGsT8qDLItaThmSNlumXfd9Yve6n4=
X-Received: by 2002:a17:906:ef03:b0:b80:2b9b:39e4 with SMTP id
 a640c23a62f3a-b8793254a97mr1070096366b.55.1768848495687; Mon, 19 Jan 2026
 10:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com> <aWioYpYPAPOGmnHD@smile.fi.intel.com>
In-Reply-To: <aWioYpYPAPOGmnHD@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Tue, 20 Jan 2026 00:18:03 +0530
X-Gm-Features: AZwV_QhchOSaSCJR0LGEeIj1jCGqD8irOEHt-fPzfOrMHBmba7_t0lBl2gV6yOs
Message-ID: <CAHc1_P6Cv3fAKjSnPKgagi8t1R1RHsavSHGns3veXNynoTghLw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: proximity: rfd77402: Add interrupt handling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +     i2c_set_clientdata(client, indio_dev);
>
> Is it used?
Yes, it is used in rfd77402_init().

