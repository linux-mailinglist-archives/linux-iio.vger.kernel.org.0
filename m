Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE534185E29
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgCOP1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 11:27:18 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54046 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgCOP1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 11:27:18 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so6734007pjb.3;
        Sun, 15 Mar 2020 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mGXR35bU5qm1U7qNW2ZN1smVSI2Jo1S7oyDWpYc57U0=;
        b=sCuvRupj60IKCUPzMxcihjKX9W/3DqPT+zlPwutcrV5v/t5IWkYWRv8b7yc25SJRXA
         3DwEnn7RjL9d5kg7Hr6kAI1CIhtS/atOjw6i0DK+Wsb2FOExI5qdyzyJuZeHMZUXISkf
         +kb4YtR9c8jHcVjhJMiiVmUg5pRdYO1wdTaUkmStxEMcPDJAR7aeQYC+VkTmudaXhVUo
         yQvI3/WilL0AxkSBcrGNnniIrVBzd94WrGCjZurheHf7zpZ7LUQYYPLGZL4iHYjrGU7+
         BVezSNc7q6ugDKnB2ymYuaHWJiU+AKY9MHV2JBdUhMzbMcNhUAcx9wnZPYVZXOWMH840
         xXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mGXR35bU5qm1U7qNW2ZN1smVSI2Jo1S7oyDWpYc57U0=;
        b=EEb16ThXp5hlV2f5pY3Pb0v7VsNAkcYzVU0orVaQQheqMPhpg0o2i5FLmPOCPXWe/D
         XgRyWeVyAO8Y6HYdVWHQ61aKF28XjnCBokHX7eUK0TImc+02D1LWh7MhQmoutL3ZWeon
         aymctIVlVb1O5//7z1O6ikXdvkhB0PhQadUoGsDfu+FQkiFuE8N8W7AlInj+37+gD77b
         7qTYs/djwMb+wiHUBcNwSmtBGjKD4d4+QECRZVrDf+rLPGGjKQbwB9/LHKyBlONF15vH
         EQ69A024koFy+FP//05jqBDU0zJHqAbWC5oFQ/vFrWM5H4wn+gxWqJXHeiAogpsv+9Ea
         xQyQ==
X-Gm-Message-State: ANhLgQ3TkwPnLowMUICgRHg1W1Mk1cBejrqKonp+wPH49E7qSh3jS31w
        dBZ0VRfWiADRZm63sgG+6YXRcC26EAEfjg==
X-Google-Smtp-Source: ADFU+vvnDJDmJDtqXmERtHqvEne715zGSS9BsSk74x0Puv75jW6HQJv3v5yy1mr6Zz+y6hZEi2Rp7A==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr22366291pls.23.1584286037600;
        Sun, 15 Mar 2020 08:27:17 -0700 (PDT)
Received: from SARKAR ([43.224.157.36])
        by smtp.gmail.com with ESMTPSA id 18sm65112537pfj.20.2020.03.15.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 08:27:16 -0700 (PDT)
Message-ID: <5e6e4954.1c69fb81.f5a45.b76d@mx.google.com>
X-Google-Original-Message-ID: <20200315152713.GA8180@rohitsarkar5398@gmail.com>
Date:   Sun, 15 Mar 2020 20:57:13 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandru.Ardelean@analog.com, dragos.bogdan@analog.com,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: health: max30100: use generic property handler
References: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com>
 <20200315124955.207d515c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315124955.207d515c@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 15, 2020 at 12:50:39PM +0000, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 08:59:13 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> > Instead of of_property_read_xxx use device_property_read_xxx as it is
> > compatible with ACPI too as opposed to only device tree.
> > 
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> 
> Look at how this driver is probing from DT.  There is another thing you need
> to do to make it possible to use PRP001 ACPI based bindings.
> 
> (check what Andy Shevchenko did in a similar patch)
> 
> I'm being deliberately vague as useful for you to understand what is going
> on here for yourself :)
> 
> Also, make sure to check you have cc'd everyone relevant.  Here you are missing
> the driver author. +cc Matt
> Jonathan

Have sent out a v2 with the required correction, although I still dont completely
understand how this ACPI magic works. In the process of going over 
https://www.kernel.org/doc/Documentation/acpi/enumeration.txt get a
better picture.

Thanks,
Rohit
