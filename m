Return-Path: <linux-iio+bounces-2678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F78585A7
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 19:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849ADB22791
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F2F1468F6;
	Fri, 16 Feb 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giNGUbJU"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C41468E1
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109115; cv=none; b=Mw76o1fTWPLj+c28fW7qDNWR/ecoAUdnRIPgZNHrcMmtsZ0IPw9vWKz5ffjca3cTHN35eIgmVamYEZTwGRDY7G9dVI7O27OAX10708ka33TkGRZ3k6XMPAFQp6OJj9e6bgri93vBfn6bhjvmMGED95NaZzC2SbhXwppCsoxby1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109115; c=relaxed/simple;
	bh=C9sMXAMP3+3ORE4WE0PAZfs1keOVwj4dX0e0/ip4uYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJpbwpEbd4n6/2IDU7Hvr9NRBDVAt6dapgFkaKjv3JyOtINYWJl3g5LqKIgIBNNASgDNb/nfQ8f+Li8rzbVtvLtmJE6nIOHvae+0U3TkalOLQFgbtUZwPZXFqVaVeP4OllWryr4SO/oJybftukLxzb83M70nNAVixXyys6F9L/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giNGUbJU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708109112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00B/Yc+n463w0waoIpRE0j19npekKoQ0T1wHM5vf8eo=;
	b=giNGUbJUn965WRjOzJkgarc6z30apficMujI5rrsgbeor61bWVnFcYhSiPRZdhkJ2VRupB
	itZ2ATF8pesOzKEIOcR+pQP5uPNJsNpcAo9byYS3JMeTdSTuUklOz0y3JzZiHupElcYVwf
	Kt39kmDeYvEFfmDBQixm0QS+UMc8lBk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-bolfdmEjMaO9jEUnXrIJWg-1; Fri, 16 Feb 2024 13:45:10 -0500
X-MC-Unique: bolfdmEjMaO9jEUnXrIJWg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b068401b4so272824166b.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109109; x=1708713909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00B/Yc+n463w0waoIpRE0j19npekKoQ0T1wHM5vf8eo=;
        b=nHBCZDRYaHfdNOrW1jQvn67dIcLCYXWlG5hlNWGzj2Qz0p4uonuk0NsfPq1VZza+QK
         ZVvWKquX7zYn6+zJLFqasZcj83wLVbgS8v7xSV6Gdo/awBafB/ueMJnC2EgbVUiZlXVG
         Y+ObSLP7GxzTQd3kKcthguy8Y8Blh3CadqPk9QOTYdJ5im2+WMaj8rjeQLgYc8qbbqtn
         fADGAh2ANP2PZbLjfU3WufS9rMSmFBcfGWXm2mYYHTW/xbJHX3x+9uWyDpooMixS8tn8
         3bocmoDe7ZA1Ra0KDvay9Zvxe0NFpRmigOIj0vEfA9/fSUPa0LWwSM5Q9QFgKxTfBvUe
         XRXA==
X-Gm-Message-State: AOJu0YyNJVyZnqgOMfffU+GZA9fCpwufm20Vtc5pfCFMLzq2rNj6iH8M
	Kj0Q0jCfO/YCz3HmsuulJqPloorLJ1ILb/E7hi2FHjJoTjKjuEUNcBOZ8w+zRhp8FOY9NEKEbJ+
	X1miHeSeMgui3mw4dSZ10RA8DuAattKuN0162+7HygT4C07kQB1C5lhsw8w==
X-Received: by 2002:a17:906:6416:b0:a3d:48cd:9d13 with SMTP id d22-20020a170906641600b00a3d48cd9d13mr4946146ejm.19.1708109108927;
        Fri, 16 Feb 2024 10:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2UT5Eu0DR4HuuxZw0M4SYbG0Nq8Th0PnZPqgKaTrDQ39gAghtYc2y89wpXRkVY/sfvicsHg==
X-Received: by 2002:a17:906:6416:b0:a3d:48cd:9d13 with SMTP id d22-20020a170906641600b00a3d48cd9d13mr4946140ejm.19.1708109108675;
        Fri, 16 Feb 2024 10:45:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id rf23-20020a1709076a1700b00a3ce36ce4f9sm232196ejc.83.2024.02.16.10.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:45:08 -0800 (PST)
Message-ID: <298cba01-25a7-4c5f-92ee-e8d3254f2eca@redhat.com>
Date: Fri, 16 Feb 2024 19:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Add bmi323 support for ASUS ROG ALLY
Content-Language: en-US, nl
To: Jonathan LoBue <jlobue10@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jagath jogj <jagathjog1996@gmail.com>, Luke Jones <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Derek John Clark <derekjohn.clark@gmail.com>
References: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/16/24 19:16, Jonathan LoBue wrote:
> From: Jonathan LoBue <jlobue10@gmail.com>
> 
> This patch series adds comments about a duplicate ACPI identifier
> between devices using bmc150 and bmi323. This series also adds the ACPI
> match table for devices using bmi323 to allow those devices to load the
> proper driver.
> 
> Changes since v5:
> - Updated patch titles
> - Add patch description to cover letter

I have just tested this on a Chuwi Hi13 tablet with
a BOSC0200 accel. I blacklisted the bmc150 driver so that
the bmi323 driver would load first. The bmi323 driver
"successfully" fails to probe and after manually loading
the bmc150 driver (to fake a module loading order of
the bmi323 driver loading before the bmc150) the accel
works properly.

So from my pov this series is good to go:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





