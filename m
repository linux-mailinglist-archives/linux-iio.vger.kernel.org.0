Return-Path: <linux-iio+bounces-4348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0398AA94D
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 09:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395041F21BF6
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761B524DE;
	Fri, 19 Apr 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hajYNQE+"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F24CDE5
	for <linux-iio@vger.kernel.org>; Fri, 19 Apr 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512181; cv=none; b=VXHd1FwahY2f1IecAC4+2HcNKmtfUok+jlMMM05Qe/FREwoQDkAJTMdHAB/CJ543q42Vmqt7ZsLeyzXDm2cV30ZceNyYEaoSsSQbHqXvPM5F3c7Dq8g8azlnz/5xdI5n37hkjyxjxQhOWBqMcOaPMOVf411lDV9LXh3JmGW5CTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512181; c=relaxed/simple;
	bh=7o/LEXSYhH+NWcrB6kTUvStmSVkDYtnWWFf2qNJJe2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJXC880aD96C2j/fR4AyLZ+1dJbHtiWVWXpsytsiVldi/3V8atIycRkMqZvP53BbHMmOrLNmC3xq546cN9ihgxL9Tp7koAjLGF7+TKNjeShWb/REoRF+SqQiLw0+6fw6VJOk9MnEv1Q6UAF63ScnnXGuOtlRi8n+kz6tcL5NBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hajYNQE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713512178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QWBypVEO4k7QWPVmDo/MhJxUaQCsvgRLuzz3Xq6IWI=;
	b=hajYNQE+ZA43E/MiGpj1gj+a3r0tIsEBLm1Q+ls4UQT3CmHpRaEvUQ6et5r3BNzJ6yP4uh
	C9UWadLiWNVrJMpfZAqwrjyiJVHCydcC/v95+gBho5nHNrb6abl0b7BNuAMQh3IOL++Bza
	6E568Vm+IHcyLtL0br2qcpbYuAVZx90=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-2KqgRxb0OuSzK0kMd0a-6Q-1; Fri, 19 Apr 2024 03:36:16 -0400
X-MC-Unique: 2KqgRxb0OuSzK0kMd0a-6Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516c2460d95so1266379e87.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Apr 2024 00:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713512175; x=1714116975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QWBypVEO4k7QWPVmDo/MhJxUaQCsvgRLuzz3Xq6IWI=;
        b=lfi7oV0x9QXXhHEW2+iRoLa6r/dV/q8gsoWuapdVCusrI8/nOsE1jpjErBF928vTNb
         KFDzn1MvMs5UqRlDfDVxFQ3mlj7MS0wM7iXcmqE5SXHEnAHOFbjhOsEMMLA1/xeZieA3
         B3b7X807tLo/H11uTpauAEVGSOud21og/H/unse7tOb6dKwo3Ss/nVxiGzkkAkBwUC2w
         4qoozHLJa6a4R0dXLw9b/KI1UX4zyiN7sIL25GMN/1onAYOZ1jFDCzCr3UEwztzjRc8J
         SFeMGB7M1YiNDLqW3txGRSfZVeuNzILXdef5/9Koup4Y2ZObabN/iMWc2DtbbjYgRjK9
         gshQ==
X-Forwarded-Encrypted: i=1; AJvYcCXATDxeQD0zB63TALfDoQhmfez6/HhiCc/9rxa2LT/ikFZpNJ/FXpdhDdAarbELyzoODoMvdcbDKcDoKwgEBNbASjuDYxlrtCwq
X-Gm-Message-State: AOJu0Yzkj9hm9s/BAHzHrw0P7kB7x9YH0pa4rW7SVnvu+vzC4OAYUWSQ
	5ntzzhkt962GUY9sjEHcRbi2E4CVfp28fqlnMqSu6LGHyZeBszRHLp0QHajtG5TSqNAJuKKKnBR
	SRvZ2eX/NqSlgoAkeQAp/UayUtEH3DA+hlIAoKRaO9nyBS4sNxW2XpuHYWHR35QvK9A==
X-Received: by 2002:ac2:46e9:0:b0:515:d135:68f2 with SMTP id q9-20020ac246e9000000b00515d13568f2mr706252lfo.53.1713512174982;
        Fri, 19 Apr 2024 00:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9HffbeF8a075TfKT9IlJ9dtm/z8AAxqtvuQ3GZIACSwbvWcOFEHvpwG+8UEFPZuzFKtXNw==
X-Received: by 2002:ac2:46e9:0:b0:515:d135:68f2 with SMTP id q9-20020ac246e9000000b00515d13568f2mr706236lfo.53.1713512174535;
        Fri, 19 Apr 2024 00:36:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709067b8600b00a524531a580sm1860325ejo.152.2024.04.19.00.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:36:14 -0700 (PDT)
Message-ID: <67ab3fd1-a0e7-4935-86db-f220466185f3@redhat.com>
Date: Fri, 19 Apr 2024 09:36:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sean Rhodes
 <sean@starlabs.systems>, linux-iio@vger.kernel.org
References: <20240417164616.74651-1-hdegoede@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240417164616.74651-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 6:46 PM, Hans de Goede wrote:
> Hi All,
> 
> Here is a patch series to refactor the ACPI ROTM orientation matrix
> handling in kxcjk-1013 + bmc150-accel to share the code instead of
> having 2 copies and then also use the shared implementation in
> the mxc4005 driver since some MXC6655 ACPI firmware nodes also
> include this.
> 
> Note the mxc4005 support is untested, I will ask the report of:
> https://bugzilla.kernel.org/show_bug.cgi?id=218578 to test.

The ROTM support has been tested on a tablet with a MXC6655 now
and has been confirmed to work.

Regards,

Hans




> Hans de Goede (4):
>   iio: accel: kxcjk-1013: Simplify ACPI ROTM mount matrix retreival
>   iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
>   iio: bmc150-accel-core: Use acpi_read_mount_matrix() helper
>   iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method
> 
>  drivers/iio/accel/acpi-helpers.h      | 76 +++++++++++++++++++++++++
>  drivers/iio/accel/bmc150-accel-core.c | 45 +--------------
>  drivers/iio/accel/kxcjk-1013.c        | 82 +--------------------------
>  drivers/iio/accel/mxc4005.c           | 24 ++++++++
>  4 files changed, 106 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/iio/accel/acpi-helpers.h
> 


