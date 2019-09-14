Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F94B2B9A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbfINOZe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 10:25:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46613 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387786AbfINOZe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 10:25:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so16794521pgv.13;
        Sat, 14 Sep 2019 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wB9cXcfvbf3mwLKf2tpUhCp16iJNh56Jini2hzIK9c=;
        b=cX2YLVmIaDJM4S+gfal9TOTVyS5Pn4yZAD7cp0KCqRneb/GNbQgg/OhGdJs6U+zBFq
         ntCLkUEEwTyBknm+20CGqFBikSP1SAncl+jNjkf9RcoS5nn/hPF46/zoNQlW33YY8wbk
         VOHIzc9Mg3MPVvvNl5JqnFphzZMCPYOTGsLa5q8nzcN9Sk7s+ZTDcz3+YvWuGKHDHJX9
         UX3piwqiarMojilt1Nnj4smPdsY42b/LeNaa3FOicp09lMPgrzeQdSqmjOb8e0ngf138
         abgi/ANQHK5aEYEU7EDx189BRPv9e3ZUhsCavJ+6h4+p3hU8om0qYXn+pHE5eLOq9M6v
         gNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wB9cXcfvbf3mwLKf2tpUhCp16iJNh56Jini2hzIK9c=;
        b=HXZ8lDXkle5guPvnN8RZxlsLyz5vWVD4WO3J/2gU1g80FW7RvYwGsBXJ7Tbc/6cCIA
         S5XcN6eIeDj28kEG4rALNxOi/IPFFPxqeSqLDdXlrjKhrW7emj3PDfrJifaCtEuSX+9k
         v4uhsz+eNbA2HP30CpQflq0iTJaJdK4Qk8abSxvO/wms74TDStixq56+VE9QYB0Fpgi0
         qgb1I2fVDDcJ5FKc7l2mkBWgAyH5fkOqxGrqRr0ky5zgf+aaItdsl4eJ5t/phnyiUhmJ
         +vLuV7Uk3p9a7CIpP4f6bD176S9DgASihl5JqDK86TL9nc1NCatUCWn4jO9Vu/SZDM+B
         eUrw==
X-Gm-Message-State: APjAAAWWsQykfhq59cjJ+qugY4BocqWNFqppHzmud1ezU/UFvGofGP3t
        Z2mQ2SJSBbMe/2AiSmiNXk/pqBtn/wfS/g==
X-Google-Smtp-Source: APXvYqxci6US66bYwRZZriiTu3oA83gElwc4xFey98mwQ9ncNhRtmQyODpeyMmCB9E3WsJA1TCHZHA==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr37176480pfh.207.1568471133422;
        Sat, 14 Sep 2019 07:25:33 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id t8sm5658547pjq.30.2019.09.14.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 07:25:32 -0700 (PDT)
Date:   Sat, 14 Sep 2019 19:55:27 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jay Aurabind <jay.aurabind@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
Message-ID: <20190914142527.GA4158@SARKAR>
References: <20190913173821.GA5986@SARKAR>
 <20190913180103.GB5986@SARKAR>
 <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
 <alpine.DEB.2.21.1909140756470.5193@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909140756470.5193@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 14, 2019 at 07:57:48AM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 14 Sep 2019, Jay Aurabind wrote:
> 
> > Hi Rohit,
> >
> > The required config options need to the objects in that folder to be
> > build. Apparently there is no way to automatically set the required
> > configs. You can look at the Kconfig files inside drivers/iio/accel
> > and see what are the dependencies for building various drivers.
> 
> It looks like some of the drivers are individual files.  So you can also
> just compile them one at a time make staging/drivers.iio/accel/foo.o.
> 
> julia
> 

Hey julia,
I ran a `make clean` on that directory by mistake which I realised I
shouldn't have done. Hence no object files are there.

Giving me this:

`
make drivers/staging/iio/adis16240.o staging/git/remove-include
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
make[1]: *** No rule to make target 'drivers/staging/iio/adis16240.o'.  Stop.
Makefile:1772: recipe for target 'drivers/staging/iio/adis16240.o' failed
make: *** [drivers/staging/iio/adis16240.o] Error 2
`

I guess I will have to enable `CONFIG_IIO` and rebuild?
Although what I don't understand is if `CONFIG_IIO` was not enabled how
were there object files in the first place?

Thanks,
Rohit
