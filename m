Return-Path: <linux-iio+bounces-6727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9755A9135E2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437B11F230B6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271014CE09;
	Sat, 22 Jun 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/g/T9Tt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCED44C86;
	Sat, 22 Jun 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719085444; cv=none; b=rjQvAyTLX43TpdEJMsjxpu200xAW9fiDX+dG32iYk1L14wWQ7s6XoY6TG5s6T8DOm9q6w7b1BExVhiEgKkjWnrhQgbkKN1iUpK8jTuh/a7WnZ63SgYgP8sBwuhqx9ttxaQ4+SIwXMM1a+UiYu22peSbhsUWeq7rNoSE9Dnmdt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719085444; c=relaxed/simple;
	bh=UHxiMaN0gFhW4g55UEEwn7/X8WHo6sNRA+kFdfZOlIc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=He7oEsuU8KJ7IsWjUGEQXpeVypZj1gGyqqiueaFUOXBveR/6ktdRyYYckzjRnFjzlyCO0exGbfSjvWGVltti80ooBzi6Sa9mrAybPkRf05eED98en4x2S6EtRSNLnCzdLDNx21NWUjMGuacGZJCOM0m4+tlI/UgENm3BN09MEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/g/T9Tt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2973859a12.0;
        Sat, 22 Jun 2024 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719085442; x=1719690242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHxiMaN0gFhW4g55UEEwn7/X8WHo6sNRA+kFdfZOlIc=;
        b=P/g/T9TtXy5Oo10SBoAHUfVuYlVOt4EvlOu3zs7qIhoaYmjnqLNilIOcFsTLm2bsxq
         l9pwYNs947VkhMEYu4HMclqtYzGlx5eXcbUMfjU0KOe2hCm+Ysrf/qdx1OoIzIU2nrYB
         mM5a5JlHpQ0AMu9VqFLo5AjbLXXXCAuxNjnAxl/mUJEzcj39JDbffbgx8Q8nSCI77XKk
         U+Rouvxb6T+JU0jgu7Q4OAAEPZXDBrvjDz6o64kdoCYfYOUPv3K7xd7JGjPKffHDms3S
         mqbAo9Bgd8xcfCKOZvlINjQ9KCor8haT4YxpVfzlQLTDHc8bvkugmZh6WUzIf0ClWDsf
         uL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719085442; x=1719690242;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHxiMaN0gFhW4g55UEEwn7/X8WHo6sNRA+kFdfZOlIc=;
        b=StQ01L9n3/U1A/mx5neOyLOMbevo6CDlFkavjfIJ7LCYWVkYygCzdThrSDmAFAJA/Q
         RDFsxnFh+wIhw5mhfutZ21LU8xh6WoAzH1bvf+eo5t2frcZa/ThFjKBQE3uQy3wi/9/B
         vuOa+nH5Imu1x6fyXZkcKN9H/2dkTgMzGjTu4g0/1FQFht4Yg5fVmvPIXdv0eT6ef8Fb
         sdhBW+EccwGEBzmT2t8a000r/h0vbQCh3COnC5W3aDdHuiC+2s7WJPF/SQT5RHletCMJ
         GRRJUHjmZHgacRBODayrPhDiEQnPRsb3p5bTGfpsJSGTdXcH9lwgYbovGAZR88vwvtWm
         iSow==
X-Forwarded-Encrypted: i=1; AJvYcCVLnC4QZNfHzn6cGmF30195DlgRZYkP24YTjdoUE7y0QYqG9MbbFGVxMgXbtjhwfqGn6OzOWq1cu02m8sPiH2QeoCf7rUljXJNY7cbnbJGYb0TOXdgzJJw0FlFeKKqrjmwloA7+sqAYCfOeJm4vpt2okC2XLOftJXjiAkfe15v4
X-Gm-Message-State: AOJu0YxjZKMRS973mbP2qA/BtDetMQ1Io8iOOIZgQx9XTtArevaaVU+b
	xf0G2QbqOkEeraWVv3F3vd+q71AlKNP1vQ48sYNV7jfMo/B7HrXFPLumeEpTRdLOS8cIhSIBqip
	aDIyhAGx1/Vw7ScKaEEjl+WhzRVI=
X-Google-Smtp-Source: AGHT+IGBVQKMPe0M8mY48RH3WL+xzP9JIJywn8bTvbczBfmZEJoCfLWW5yCSoIOe3OKwAcDMgURS5hQXij0URVEfi+0=
X-Received: by 2002:a50:8e53:0:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-57d49dc29d1mr698479a12.24.1719085441809; Sat, 22 Jun 2024
 12:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Philippe Simons <simons.philippe@gmail.com>
Date: Sat, 22 Jun 2024 21:43:50 +0200
Message-ID: <CADomA48AbhFaQ2yWpBYfsTiBLyGDMeqbNbxhU_j1Oi2DEeaxAw@mail.gmail.com>
Subject: Re: [PATCH 7/8] power: supply: axp20x_battery: add support for AXP717
To: macroalpha82@gmail.com
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	jernej.skrabec@gmail.com, krzk+dt@kernel.org, lars@metafoo.de, lee@kernel.org, 
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, macromorgan@hotmail.com, robh@kernel.org, 
	samuel@sholland.org, sre@kernel.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

sysfs correctly reports the presence, voltage and current of the
battery. Tested on RG35XX-H (H700)

Tested-by: Philippe Simons <simons.philippe@gmail.com>

