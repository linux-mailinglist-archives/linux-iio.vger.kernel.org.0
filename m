Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26B21CEFC
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2019 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfENSXO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 May 2019 14:23:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36729 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENSXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 May 2019 14:23:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so16166088otr.3;
        Tue, 14 May 2019 11:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJM+GBkUu/KSiPUs87tSjj6fH1n6jC/eS4ffHGbTOqo=;
        b=iiSMnWqWrYW/3DpZiGhKDvJfTt+w5rpMQqE5c6jXFpEhLs//RnkOtEh8v3CCnwtR0Z
         hh+zwRNn56LsXjBQUTadcguPILRnLrXhWE9+EjcNaTqkERe6Lp1rbPwWd6V3ytUAp0rm
         272Krtiem0dFnUcW5fG/JBn1dZ86SXT5dPo5k1jTUCohMRX+HPKP5n0RQp6rLnXIuVd3
         pr1oQKHvbcTlKjHc/lZz2wbUd0aaNgFZTcVZrAzA1kTv7Lvm8RXxUpWtolR4WufECTlG
         +ITHIBLGZTBOZIl6f0vnEl6ByJ4S8Dy3kQ+jLFBnTSI25Osjw7/iS149mGTcEZFOU5oO
         AzAg==
X-Gm-Message-State: APjAAAUymQL4HWZGKTt3jEdC/NMfE+OPv17XpV3uNiz/Ol99n47AiGJ5
        eHVE7G9z8tD/sBuCql5HQt1jl8k=
X-Google-Smtp-Source: APXvYqw7x+JOuQpyjxYQovxpTWqfTUdQUZmBn8H3eG+MqZYjsbgPw6VYeyCexDQhKOk6Az0UQ6nREA==
X-Received: by 2002:a9d:eb7:: with SMTP id 52mr21149478otj.185.1557858193015;
        Tue, 14 May 2019 11:23:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q124sm6608447oia.13.2019.05.14.11.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:23:12 -0700 (PDT)
Date:   Tue, 14 May 2019 13:23:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: iio: ad7949: Add adi,reference-select
Message-ID: <20190514182311.GA31516@bogus>
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
 <1557759185-167857-3-git-send-email-adam.michaelis@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557759185-167857-3-git-send-email-adam.michaelis@rockwellcollins.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 May 2019 09:53:03 -0500, Adam Michaelis wrote:
> Adding optional parameter to AD7949 to specify the source for the
> reference voltage signal. Default value is maintained with option '3' to
> match previous version of driver.
> 
> Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> ---
> 	V2:
> 	- Add some defines to reduce use of magic numbers.
> 	V3:
> 	- Re-think usage of device tree parameter to focus on the
> 	actual reference sources instead of the raw hardware
> 	configuration.
> ---
>  .../devicetree/bindings/iio/adc/ad7949.txt          | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
