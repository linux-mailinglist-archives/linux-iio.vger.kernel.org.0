Return-Path: <linux-iio+bounces-4060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6489861B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6511F209A6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADEE83A07;
	Thu,  4 Apr 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owiPlvNe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A7839E5
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230630; cv=none; b=m7Uj1yqgF0EE1A15ltF1j4ZTVcsmXt5cCu+KvkF4s4zQk23E28LSq7uhWiXvm6ZcemAOW3sXoT32qPcmAJCR0jwuQ827tb0dFbLuHoOhTe1xr9De3RsiL/82lJkhk45blvbdCBq0CBQHjB9wHpcfh4RHqBcjE2otvbPT2vNec2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230630; c=relaxed/simple;
	bh=KFAldtQ3Ri802efWe3yxZ4uwt3H6zD9sq1tm+EkHqqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNRCJQ6zs4mLRsudGRSHhi138fyjznTVsFZKsK0/sV8cA155zkwegs5tkXh7VEt6ZnXoW+Ls6sRyG1nIJZlSK147Tz1RFnW3bQm0g0dihv10G+o0KoLbKBCm9O7Xv6QLe6K+xavfjWxqB7Y+8hF8FsNlArphncaK8UBhRO8iAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owiPlvNe; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6147942ae18so9264197b3.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230628; x=1712835428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFAldtQ3Ri802efWe3yxZ4uwt3H6zD9sq1tm+EkHqqQ=;
        b=owiPlvNe8luaCLyhWQ2FH19mSf5c1yJBiyUSZ7fZdPnF2gCOhd5QHKEffExBxyroy8
         5GlSx4ZvyPqJNZX61qu7/5kYYvTKeMt+UKSXQD7cgcviVzCSp/Ixv1j/dbE10w8BdN7V
         rQXJ3e8IYNGl1DHw+aFjdESUW4ijB1pEo0yCLBohZKoOEdipcIxwvfbSKfSZZFaQ+nlJ
         NT5DoubuaFHi9FmhKIfPrh5RQlqMHe98CQcY3Hejfi5ot+DRqmW144Jvs8ZBCjUiJj2z
         eneWHsG9Kun27ooXYcs3aZz1Ki9KhOgeQLqWMl99ORL1OUXdk15iy19wlSBTO4137chV
         lbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230628; x=1712835428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFAldtQ3Ri802efWe3yxZ4uwt3H6zD9sq1tm+EkHqqQ=;
        b=F2ToxmW9n5GHbK/cWOH7SXC+6EdyANJTbR5dTOrDrupOepacJm7F8Ke2ax8sBI+233
         zT1kQYVv+S2MEPr9OXqKRsxvhPagJUlEtoAVbdyHUPprXUd53PzEImtQhzmMaP0UR8LT
         ewCo8KW+A+HI85P7UNW2QqECmczHCW4arqTnOaGAUGp102z1tsS2Oj2X5mw3jc8uUo9k
         bqdJzxfTm870N1qZzALi614MCXDBB/M5PnxKKMYrQkP/kHdiCWEjlvvxHz02nYJvwbog
         barm+ULOdozd4e8yWbTIqkoq9UysiUjBsjUuRibOQbWjgkX4sNSOU33UL/QjxSNmDyRb
         ggLg==
X-Gm-Message-State: AOJu0YxgNWXd1EbYnH4UCGymYwzcrVqxBSsg3w9fi8mB/0CHsctTy+pg
	Jc9COMSzleVyDHo1hu1A2RlVijCgkXGUze5bB1ruF9Ec83WA92igvLw1H17eUu0eNEaoSrGeJZp
	83PYqjIUymIrigvlfp0+PTIKom83a+v932vTRG7VjZYuKTyyu
X-Google-Smtp-Source: AGHT+IGY0WPJRxMxN9yB/L9K3VHSyWz+4DdmreVuXsQFzr/k93KexUXP2w2WQi5Q5ubWt44YBr7GVLxJt0onyYrZW+o=
X-Received: by 2002:a25:bb52:0:b0:dc6:d7b6:cce9 with SMTP id
 b18-20020a25bb52000000b00dc6d7b6cce9mr2009629ybk.57.1712230628019; Thu, 04
 Apr 2024 04:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330190849.1321065-1-jic23@kernel.org> <20240330190849.1321065-3-jic23@kernel.org>
In-Reply-To: <20240330190849.1321065-3-jic23@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:36:57 +0200
Message-ID: <CACRpkdYgUXA810X_sg5-N=K5=oVBYf2u42=EAwzAWQvyfnrSUg@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Marius Cristea <marius.cristea@microchip.com>, 
	Mihail Chindris <mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Seems these got renamed at somepoint but the documentation wasn't
> updated to match.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

