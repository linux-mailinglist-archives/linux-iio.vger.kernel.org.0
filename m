Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E133BE8D9
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGGNdf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 09:33:35 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36640 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhGGNde (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 09:33:34 -0400
Received: by mail-lf1-f51.google.com with SMTP id y42so4109064lfa.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jul 2021 06:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:to:cc:in-reply-to
         :references;
        bh=WtLzF0PsDR294VsIIMxk4OtyyNT8nUHidsByZULzof8=;
        b=Bgmx2heK0T5kpjt2rmYXFiaiyla2Lb8CzyJvQy7A0A21U5xQXgM0Mxi4NtVF7oI7d9
         Im5sml4VEdoZbu4QtymxAhkzdQ9Z25izAVjHWm2lES9LPFwEKvRMMpPzzwczhNr+7Tr1
         ZEwQmAwhU2HSKUGNP4ouxKYyUazeaEC92iVcveM1CZLVI0V/4wHy+cRcmm9CnxHGi2X2
         qGadPagNq6G4S/t5NyPuW4LvA6ldqk+1PgNX0I0Ji8AJBvtuYFQUve6ExnuOGNIDBnxX
         dB17eHeKwD6xDhoKJSca4kOPQQsAfjgICz71JN8itLMOeGuVXPJAtHO56ipJas+PWJOA
         QF1g==
X-Gm-Message-State: AOAM530Uf6N45/iyrdUoCTnfY53M7NbLOXyY+NGXJ/Eni8WKPA1dPcTq
        T1MxCwMZgw1m1ATf8U4A+jA=
X-Google-Smtp-Source: ABdhPJzsDopu0cpa3yr/H9ff4D+yNzOLGtkuO3IP8PBXf/pFpg1jo9FDjbUK6I7CsUDPVYP+/lx1lg==
X-Received: by 2002:a19:6e43:: with SMTP id q3mr19017702lfk.265.1625664652610;
        Wed, 07 Jul 2021 06:30:52 -0700 (PDT)
Received: from localhost (88-112-11-80.elisa-laajakaista.fi. [88.112.11.80])
        by smtp.gmail.com with ESMTPSA id a8sm2015771ljq.127.2021.07.07.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:30:52 -0700 (PDT)
Message-ID: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
Date:   Wed, 07 Jul 2021 16:30:51 +0300
From:   Hannu Hartikainen <hannu@hrtk.in>
Subject: Re: [RESEND PATCH] iio: adis: set GPIO reset pin direction
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Antti =?iso-8859-1?q?Ker=E4nen?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <f82dcd9f-c7f1-1619-9ff2-95066b82c77f@metafoo.de>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
        <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <60e595b9.1c69fb81.5284.9247@mx.google.com>
        <f82dcd9f-c7f1-1619-9ff2-95066b82c77f@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Jul 2021 14:25:06 +0200, Lars-Peter Clausen <lars@metafoo.de> wrote:
> GPIOD_OUT_LOW does not mean that the GPIO is active low. OUT_LOW just 
> means that the GPIO is configured as output in the non-asserted 
> state[1]. Whether it is active low or active high is configured through 
> the flags associated with the GPIO descriptor. E.g. when using 
> devicetree this is typically the field after the GPIO offset.

Oh, I misunderstood that. Thanks for pointing it out and sorry for the
confusion!

Your original suggestion of using GPIOD_OUT_HIGH sounds good to me,
then.

Hannu
