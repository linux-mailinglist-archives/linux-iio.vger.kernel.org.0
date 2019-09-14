Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81A2B29E6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 06:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfINE6H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 00:58:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42607 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfINE6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 00:58:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id z6so4350588oix.9;
        Fri, 13 Sep 2019 21:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVHOS9BNj03IZpMZKyDwiSCTcORD0810GaEv6C57bW8=;
        b=H59uWlS4sQI3sTX2qZ9i8YFv2wn0rDGkVOcIW45oDk1vZmX5feKYdAdUhNq1LAouOC
         AQyjwIqQIVceDSGKUkS+kk+mOERv+zArp57Gw5cjGFlMnv1u/HI0uTZ5sH+ynRW6qjwg
         vPMtrvb5kibZNnym79UUwQ53nZz8/5UiqGQ3gSrv/QrDRzeyHrcIky9+pDmScTDNIl+2
         DneB7IvdG11fBPJMEHsXYtrPfLsCQzpZpuFJJJJecI0Tzg07xY+hWhWHljCHsO+hadRH
         NL0sHvRMOO1XrNzzaL2xbVyUcwKqvunxRs3BSp/pTUi+rAGSPWORL2T6saoFf3+ohke3
         VHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVHOS9BNj03IZpMZKyDwiSCTcORD0810GaEv6C57bW8=;
        b=uUmQb8M3lbiCZn8MRtlqEKqvUCAcr98kV+Ao1t397I7FUJqv6wG/CnvcXDuqDYhQ3m
         8nbbGK4YCnDUVz/F1LmIE/n47FWmO5pey7OOX/1E2E0JgkghpKJG6TBMUaxPLpDE0Eri
         xBw5zyPoU1I6Ov3kQ4hEKGpNYNg//n6LQ4eChu1D5UOhUMOvoPcHXaC/kK2YNE3bVvPY
         CyePzeNRHm2+bzSJowqAfjfIyBTPLgVUtpaZjUoza0cY+fkNqdfKPvFpQ4MOVJQE0W7t
         BkPqKRnDdLE/nyu0rJmuAOQXcVcS7JdDltJqwxdo3QfAduQYMtqstA6cXtOWJ+4DonjZ
         U6mQ==
X-Gm-Message-State: APjAAAUppJ6hrMkINcuBeZMZN8K6P1DGj2rzHFYae2PlNlIKZ9opDY/S
        e3wI52Hc5MHpF80nmGHIJIrI/M3iJmmVOFTDi4E=
X-Google-Smtp-Source: APXvYqzTAq1I7sq67skOeu0LEkqVLmmpely503cN/3H9d/AGF+uYEk70WBpcz6b8/+bBUT6XLfkR9B3enl89B4jqp5A=
X-Received: by 2002:aca:5510:: with SMTP id j16mr6319799oib.121.1568437085820;
 Fri, 13 Sep 2019 21:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR>
In-Reply-To: <20190913180103.GB5986@SARKAR>
From:   Jay Aurabind <jay.aurabind@gmail.com>
Date:   Sat, 14 Sep 2019 10:27:54 +0530
Message-ID: <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
Subject: Re: Problems during compiling in kernel modules
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rohit,

The required config options need to the objects in that folder to be
build. Apparently there is no way to automatically set the required
configs. You can look at the Kconfig files inside drivers/iio/accel
and see what are the dependencies for building various drivers.

On Sat, 14 Sep 2019 at 00:58, Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> On Fri, Sep 13, 2019 at 11:08:21PM +0530, Rohit Sarkar wrote:
> > Hi,
> > I was trying to compile a particular folder in my kernel tree.
> >
> > AFAIK the way to do this is:
> > `make drivers/staging/iio/` from the kernel base directory.
> >
> > This gives me the following output:
> > `
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> > `
> >
> > No object files are generated.
> > I feel like I am missing something.
> >
> > Thanks,
> > Rohit
>
> I ran `make clean` in the `drivers/iio/accel` directory which removed
> all object files in the first place. However running make after that
> doesnt seem to compile the modules.
>
> Thanks,
> Rohit



-- 

Thanks and Regards,
Jay
