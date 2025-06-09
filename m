Return-Path: <linux-iio+bounces-20328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF347AD1A99
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45E416BF82
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4BF2512C8;
	Mon,  9 Jun 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iff2T7zm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8921A2630
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461361; cv=none; b=M9hQrjP1hIxeyS9EDxL+uw7neoTJEp5aHKMcq93XNi9msQYqaPJdGL0lZ4kKr0V2UxYYIdNtUBLmuXNAONJLxl6J3JDRKQnwG/2NbIFqmObCU9XwpUck0IxJ3K0TZwxbJ/MOfrDdfez9vS+6hMOQ2eHs9QzpXttfJaeKe75O08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461361; c=relaxed/simple;
	bh=WFgA4aVBD639vQcQM37vKiWrUYWZ/AI9jbmvuB8dmE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkV76dVJR4dKgqaBnd2tbBLNQ9sCJCP2nlLFS7MHcupixhC6pbnLaWjNlSbp++FEHfDZu7VnMpTE1bWA3UKQ9E5amEIyfHBQuy52D61cOkog+ptDNZNkFQxXAkRqJ4zkEx3feUJlzorWe7t4fiU0OQd3cmQ/4e0n0jL/Rl5YsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iff2T7zm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb2e9fd208so751765566b.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Jun 2025 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749461357; x=1750066157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5VIplWrjXSUhX7O37wVwpO9DW8kvL3AWFxZ7Ytwcxg=;
        b=Iff2T7zm/Z6BpXMU0xJSvHNCIIB48A4s6yqFRgs1Zu/u2dZ0DU6vXXw/itE1VeT0Ri
         PfJb4q6sAnd3i/ok/3uW2GWLorDE/sljzIDN3vbajghmlpzmoVwT6A7fQjpSUWyi6mLB
         f5WmiCMlJKWr/W0Qk841rpqVU9ZdKaTFE5farBOjI0H7Gjk7vhgVIyrJfk+/RGHoRqU+
         NA7F6UjOK/9IHJ5tJhC5iNnJCnydASuVB3RBgeerh+hAGVjep7KKjpcEhgIum7Xm++CR
         cyTV3A1VZCarL0KoXW8zoq1+IQM0nrVBXl+LqGCxeMoBnoYI2CFHPnnqDQZ+64sn60Tj
         OJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749461357; x=1750066157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5VIplWrjXSUhX7O37wVwpO9DW8kvL3AWFxZ7Ytwcxg=;
        b=ERXrl423CBHxHDAEB5Akn0tRNoaCbnwG310+HwQK4DlkTOSzel0oFbD0/Vw41c1tKR
         4sC9HdnWjLEncELaukuVE8T/Pja4C0NLnvPwsXf+dYl8MIuv/yHXI5Pg55ApykhHOi3f
         8Vci3jCc76g/yyyp6DPw6AIVgoade1MBR5g6yMRMfiVbek2yOnPLiUgrARjrGOy557NA
         zR70L5hdM5sHr4q47e/Ww0Z8H0NtasQEBtiXUJZ6a0/P5Yxme11rC4o8tuDZC+rDDECc
         vOQLgrzUpG/RD8QE8V586+gd3oj7nEwh88Adx6iD7ieiAEqyMeyF8AtXW+cqngduotPd
         Tn5g==
X-Gm-Message-State: AOJu0YwBeaJsXM8DcRC4u5Sg/mFWkNOgOMurj+k8/s/QMxe281lNJB8p
	XrqtLI/emfN7mNX4z4FGicDX4Wdtb6oB7qcughu7Yc2FRKJ+O+w1YYEMYediW6sy69sax49mTtG
	rT7d7fKiwJwl6SXqcAqkoIIqJpoTl5Iw=
X-Gm-Gg: ASbGncunJ+dcFZrTbIQOBKEosT1v++3j8VJMWUWB42ZdxpR1CrQmq5ROt3XBk+53kTi
	uUCE2jR76p+wALMX/6CmvQaAIoPPHkIASqbREYFSNJrBuho8+aJ9AlDyK1WEaIp5D2RbTkyARsv
	w64ppyT96lHEx6oMFm5ltAdp0E7C3+v2g/5AgPjlG1rEJqRiEe1BAhSA==
X-Google-Smtp-Source: AGHT+IG6Cnsat23Ljhuj43PVMZ8no1nEdVGt6oi6so0bjrXv2QLZ8O4C/oAlrDbdKfAHpd3x61ZVFVAlJ1xcUNu5VHU=
X-Received: by 2002:a17:907:7282:b0:ad2:2fe3:7074 with SMTP id
 a640c23a62f3a-ade1aa4d687mr1026549666b.14.1749461356585; Mon, 09 Jun 2025
 02:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609070616.3923709-1-jic23@kernel.org> <20250609070616.3923709-2-jic23@kernel.org>
In-Reply-To: <20250609070616.3923709-2-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Jun 2025 12:28:40 +0300
X-Gm-Features: AX0GCFtMs_aoX_vh4XWiSYQ9UkYipB7rOVIIMJBZUJtsOWczkYMfpFhujYjFIyw
Message-ID: <CAHp75VdxGouo=SB0JnAL6w5ZxQN0C+bBDo5Hh_k+TeoK5pD11g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: potentiometer: Drop unused export.h includes
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Resolves:
>   warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is =
present

With the given context this LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

