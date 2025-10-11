Return-Path: <linux-iio+bounces-24943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED92BCF758
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB3D4004C4
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5E279355;
	Sat, 11 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuG9WHBO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417C23A99F
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193080; cv=none; b=HNv6qgwUIhOM00Em+El1Umj2Ra4d9Z4tTL6/TbFttbq+LlTOcvnQovrMlaCmzU5Wz3vsYaMVSp99RX1VkdOpbyDXxB1XSUbh2Of9UiuSVv8/GbFp8GWKIexpXHFZTw32O5tsgWywjf5mjGYaMvOIEZQHy7Q65yX/evy+QWGQcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193080; c=relaxed/simple;
	bh=XpzWd88TyI/XLI7Lya1GQD+iwyqcUR7IMgGr5vh19aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNPNufv25+MWbsqJykVcJT2XduXlpMOuAUOYJrQGlmIidytiOIjwN/KGO+XBSw534Jci9Vb7CKT0ITBUlulGiiHyQHrxlGfuMQs7whQQzxLYLRaMK8K5AjFD4seuwLwM+XZBn7T4u+7nGrG8D+6nVlM7etdDHwdPJJH2dVsjNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuG9WHBO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b48d8deafaeso667364266b.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760193077; x=1760797877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVMNRIG9FUKK8HBhJ3beHD14SK0gN6MU+q62w8zRjfA=;
        b=HuG9WHBOSxFZeoW6SqTTgPLZFNJFZDiq6yQ5ScTPhBXdiEYxXatVomVXZGV8kSYU0V
         sd27AHj2+QFWq3HZToB3dtyRDMdcjWVCHNDn4ekFNGd8JUjCR4Ja8shx3NQZGNbHHv02
         sAdll3L/Ut6XHTFja96PbO0tPpvN+E3W6nT4b4GbdtsqgZYwWXENy5SuhtZU8XWDVPCj
         cMwE3z4FC820k7oKPi1qLXCY3EDvgxTOpsz6qv2p53vIYoSMrOglzWPCh+gglmeydbJ0
         6acLJouIgjSCoZ1eS8CDpojZyvfomcaNeW3RUDNkGXhoH0neiXuQeAoKkMHYa22kjItx
         XKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760193077; x=1760797877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVMNRIG9FUKK8HBhJ3beHD14SK0gN6MU+q62w8zRjfA=;
        b=qX5GrVZaOG9gEkkPlxQgT9mcxhCxYbybrB8/sfkfN5qyK88PhEwk4vpWQAO6BYPkGG
         JDjpgIEJRbs8tGD3cf8UyHR4ZplEF/prDvDa2ZjFGooKzOgb4QNHtNHhFR+8MxCF0U+D
         eJQMQPbL+M6qwIVWLY7/XU/ISp6YVV8O+rhLMs5Mrn5a48g8R1YJRdOpCtUQqz9r7F8V
         B12I9gzM7RBAqpG/OvEVs8Jw64DaHrzHEEY93dtm3BEEh6dHQtsHPG/EN0mIbdtzIFSN
         zPgGR+D0eDQUEwAM57HDhRh2Ye8U9T4amZXrOPhUDXP9BYcj+yhEZXWquL9nB2q/GT3n
         vHlw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SdAPceVNDEon6i33bou1fXgcULLjdyXLyCteOLuliAh19Zzbv5QcUnrZVHbZVUHp8hZ4ViFDoeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJC0QA+XY+dTUV0edUPBPSehs4zU4PCA0KqPwzMVkNflglBTB
	Tge3lNwywZGNV9ki74zcty4mOQ4nzEPMGNAT6uJYKRb6yJih8+aik8ApkZ6KpZfH8c3asbPKORA
	5KLZsmDEZM/G3cbAMtwLnnJnaVw0J1E/xp6E+uFg=
X-Gm-Gg: ASbGncuWFT9kCwW/eeZN1JL3kZ7jfWPeDqGhURgw4gCJlzhffUQRD20HdUSiDGtWUq9
	CAdspOHu78gSNmVFgW2CD9+vXBsaTiNuyC7E9Aelsm3loOFkDPsR4T0FikozW4jhwYwFSJridUK
	jpQtqiUBZobv31sGTmh+W4KwIfXBhlqIpIHTWkJrxfCtOynSvpOuMIaMZ/NDisj79lqSLGqe8Qp
	JMHXSa21c8y9xYEvF8ciIvRkw==
X-Google-Smtp-Source: AGHT+IHQvYIGg8dXvD2lz4y+qIlbjzYNb68twp7Yek0JvWJpIPtcgD0w142zadNgWyCvxFKj8ZxQdlP+k13p0MDYtR4=
X-Received: by 2002:a17:907:9407:b0:b39:2424:c699 with SMTP id
 a640c23a62f3a-b50acb0cc7cmr1519173166b.58.1760193076912; Sat, 11 Oct 2025
 07:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
In-Reply-To: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 11 Oct 2025 17:30:40 +0300
X-Gm-Features: AS18NWC_RKLNboheFfBHXqm4NJ2o3N7E8VOiWl4ZcI2QzXvoRMJ20WcAp6ctO2o
Message-ID: <CAHp75VeZuKWxocVq21PCmPdP1P=wQQ75veOzyW-YJ+WW=HAaSQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bmi270: fix dev_err_probe error msg
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, ~lkcamp/patches@lists.sr.ht, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:11=E2=80=AFPM Rodrigo Gobbi
<rodrigo.gobbi.7@gmail.com> wrote:
>
> The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
> during probe, if devm_regmap_init() fails, it should print the "spi"
> term rather "i2c".

rather than

...

>         if (IS_ERR(regmap))
>                 return dev_err_probe(dev, PTR_ERR(regmap),
> -                                    "Failed to init i2c regmap");
> +                                    "Failed to init spi regmap");

While at it, add a trailing \n.

--=20
With Best Regards,
Andy Shevchenko

