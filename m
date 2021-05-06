Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29D3754DD
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhEFNi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhEFNiz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 09:38:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E215C061574;
        Thu,  6 May 2021 06:37:56 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so874269oto.0;
        Thu, 06 May 2021 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MKp58PwXeLobakDHtjAgwNkEIWieKBtjzpMSHs6E8T4=;
        b=PAeDzOI8wMyfqopzx1o0r/NMghUjK5dW9fJxnd743jrIc/BbEBjSmWpgaoqkFNRr97
         yxFYwtNl4YueKodgnccawFq0/63RurUBz1EjtilGvisCWjRiDjRGACKDZaObNY0pyrmC
         uIZJNFdF5icSrAbg1VPb90Az5L1RHe2o4jjK44cOS1iTH4z8kxhREFYl8N08ARNASAcr
         CeODrBvj1XVmfe8+Ua/rBV9lhihTMWwvEOPt5ZHSc88BoqcwnLt5rTSM1Vck0GnrBxRf
         Yv2tfjtMYJvCi+HfitgJI0m/MR7AKlCnzr566OJEfHREk/FeWSgZ2V4nez09Ff1gorH4
         AFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MKp58PwXeLobakDHtjAgwNkEIWieKBtjzpMSHs6E8T4=;
        b=R1VuSsD4KFo/Q9VLNaJfQcc+VobMyY/6IaGcjG6j56Qe6DlnF6qIcF8N8+aaUoE3t5
         ZSaQ8QNor0tTkVFbGTrddBeJnejpNn+gQcD0I7xAfHZTDGJRarKY/HCsPmkfi+gIiuti
         QBmy4GLCNWxI9af6F631htsL6SN64g808zMsB1zo3po19vNOSl5iO2ImuciauWF+Q1Ha
         V1JPX1Z7s6AFEq68Iz18rp2vmAmgOujIVihM4dMa1UDKE2AG4XFmId6SU/zV4Cmmg4sb
         O1tIINe2a7D2ddBb+8xhpfitk4pfKhYQLadmjrYvYgbZX81NYZdQtCnI81ys8zwMGdAu
         rzgw==
X-Gm-Message-State: AOAM531dnubG0CiN87wV5G4/R3IPsca7+ojMFJf+voQ8FbTfZWOM01+O
        EMqNJFFN/q/UrtIovHh3DVw=
X-Google-Smtp-Source: ABdhPJxXtKtjALjahA5qGAYSaqUOktqzjnmvB7cyAaHTXdAwZeuxvSrdyLiYFSQ0hG1R6+ySzkLlMQ==
X-Received: by 2002:a9d:4c1a:: with SMTP id l26mr3614916otf.181.1620308276134;
        Thu, 06 May 2021 06:37:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11sm402517oiv.19.2021.05.06.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:37:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 May 2021 06:37:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
Message-ID: <20210506133754.GA2266661@roeck-us.net>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 06, 2021 at 12:28:40PM +0300, Andy Shevchenko wrote:
> On Thu, May 6, 2021 at 6:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > With CONFIG_ACPI=n and -Werror, 0-day reports:
> >
> > drivers/iio/chemical/bme680_i2c.c:46:36: error:
> >         'bme680_acpi_match' defined but not used
> >
> > Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> > ACPI support from the bme680_i2c driver.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> with the SPI part amended in the same way.
> 
Right. I just sent a patch doing that. Oddly enough 0-day didn't complain
about that one to me, nor about many other drivers with the same problem.
No idea how it decides if and when to make noise.

Is there a way to determine invalid ACPI IDs ? I could write a coccinelle
script to remove the code automatically.

Thanks,
Guenter
