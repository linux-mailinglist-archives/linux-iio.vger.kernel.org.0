Return-Path: <linux-iio+bounces-3662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A3886455
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 01:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A401F22B96
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F6387;
	Fri, 22 Mar 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad6FZbi2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D08376
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067301; cv=none; b=I3uNjaldWKDxIlTyKp7H+udAW7tH/hIo5KnGWK+UlWyW2mq8VH8Zk+5TKQPrxKeNn1CuRrdcew9Mk3f8QnZHZJkgiI5Ivofkge1RqbhEdIPz3k5NfGahWbj8h9ng+KUdKHNALIix/e1ZW66v1IMv4LPrRE7nUdA1UBJKGnN2FNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067301; c=relaxed/simple;
	bh=QrKkppO28KXlF2NSaQI91PURjkRT0ALmsv86GAJjZEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN34N5ThiuI75WDRij8z0SXyFiaMznBCX7bTFTj55bWkn4d3EZie1ifAvLdA5oy/lvOwOSIKpMZSzNm3LLGc4V3oAcfQCcL/Hh6mNaNWb3RLLRU6zte8jOOIBBX8dNipay27guWLfQLSipfUjO7eUu71WQpHokmcymie4uCI/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad6FZbi2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso1677951276.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2024 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067299; x=1711672099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWbW5UEPLuyHdNRYG0HCoOLt4yqpHHeORq6DVqer/2E=;
        b=ad6FZbi2naPnjjYX6049loRww0F9tmL5xQmslsiYlImuM60pHYvzpAbJZ+IccJr6Ys
         B8kmFzh93oeQrLSxe6C4XBvz7W4Hq0fAJ2eBOdIWt3lvgdHvAv3xrQi7o0Z6ODjjAPb4
         WD6nYh8n7JLH83tCuh/ilyNH7XvxOWTLM4FV7E+EyXEKl4OLFGfTbExFuxbvE/cshKgz
         wvZK9pkuAF3gOsVp5beVQYIMljG7J2fyRtSi6WL+z8QUyMXKRKKQGpVP8bAq/sAz1MhD
         BUsNONW2mgNTJf4Yq4Qxnu1Mxrq+eoMUk0GafUI69rfZEnM7H++7vlK+ZSPccHMPY96x
         nzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067299; x=1711672099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWbW5UEPLuyHdNRYG0HCoOLt4yqpHHeORq6DVqer/2E=;
        b=eKeM/WFzGxkhPbcNDFc+yjPmVhyzm9OC+ITCGTWXOUMsoiR6ON0pP7U2q+r9gm/zY/
         eUo2Zsgud8wFl4/Dq71DwKbCzq2OpnuHelM3hGp2uAjsmfTiqIWr5UURg5AszkWBb72p
         YRoSMVL8th1MjY5cUPVGnjThVjn5sXiDOxNejSqk7/vb5HcQrMHglNJR3FAWwouPJGdS
         v8Y6S9Iex2Y2O0BOLG3/tSfnmEcxu2bFi/XI3p7K2lE6WzZtLTiwN8UEwOMkw76duU52
         r8bpmqncdWpYzWdjQU01oPTywvKeC6XDVYOIVSDn+wW4qGPFPP8phgEGBOSD4auxZu8y
         vH0A==
X-Forwarded-Encrypted: i=1; AJvYcCXarBqeprlBRaCvTg1Jz80mVH0ZeVbuxe/XkZQB7T2jk7BWtk8whnGenIj/qNX3FlP7dgHDuljdY+GQHufydvWcrC6bxCcnPUnM
X-Gm-Message-State: AOJu0YwUcVZGFFr+M69d4ZZCJ4sW/4OB0QY1qANlKhziP6mMN+exAok5
	KBZ9S8RKWahmXCRj9vFXX+bYf6KmCeoGHkU561+zpICyKle5FJ+NGaiPYLHnNVflK74WlnlygVS
	sMbo9+8dNbHf42GP12gUsV6T7ITY=
X-Google-Smtp-Source: AGHT+IGGNVSswf5pmxkmxiP0v7evgBUrhB0vmbwjVN8LA6KEbjf7+4gWkKzpDbeAwzwGsFY0zAJIPpXO5tsKDQ7Pwe4=
X-Received: by 2002:a25:844b:0:b0:dcf:ef13:4cff with SMTP id
 r11-20020a25844b000000b00dcfef134cffmr782116ybm.16.1711067298909; Thu, 21 Mar
 2024 17:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212713.257600-1-l.rubusch@gmail.com> <20240319212713.257600-3-l.rubusch@gmail.com>
 <27a7b77b-af88-4b6b-8444-02917a744967@kernel.org>
In-Reply-To: <27a7b77b-af88-4b6b-8444-02917a744967@kernel.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 22 Mar 2024 01:27:43 +0100
Message-ID: <CAFXKEHZ3G6Ce0ZeD8snosDL9wYrEtJ7YLbjO6JQVrSDeYKZVAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adxl345: update documentation for spi-3wire
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:34=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 19/03/2024 22:27, Lothar Rubusch wrote:
> > Provide the optional spi-3wire option for the DT binding.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> A nit, subject: drop second/last, redundant "documentation". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L18
>
> Also, everything is an update. Be descriptive.

Ok

> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

Yes. Next time I'll chose better prefixes. For now I keep the subject
to the mail to not break the mailing thread and update the patches in a
follow up. I hope this is ok?

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.
>
> Best regards,
> Krzysztof

I understand. I took linux-next. I fetched it this week from mainline
kernel.org. I took "get_maintainers.pl" as a mere
recommendation rather than mandatory and skipped most of the emails.
Sry for that. Thank you  for all the information.

