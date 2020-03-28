Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01619651C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 11:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgC1KmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 06:42:03 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35449 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1KmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 06:42:03 -0400
Received: by mail-pf1-f170.google.com with SMTP id u68so5863700pfb.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2020 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xi4pieaWpB9ZbQGECXfNGW95Le7Of61cqOGJzReDeS4=;
        b=rB8KcM3+k2l2LkeHQ92KsRJslNtmTp3mZ52yLJuo0Mo+dedfDQHi41pYU+S3hb6REZ
         J06y37bkYhKZv2AMiVU3qJMRi0MFtxlMUmSBYcNLKiKYsu2nv6ljT6mXVggQn1fCpIxd
         TvHKlRbQ4FqKv7eSy5Vj1QEvRtM38nubCBSNHqpEm3wG5ITsT6OPYOjebYyP5ItwaMt9
         JLOb+NzTNriJdKALk8bV/HKlemT+ooynsvEY5TzsaIGuTDIOLLU8R4bnSTxja1wUZBQt
         XJYS7MXjFrYUEOouc0bCA9HW9BVF/hXr3J32vfr7QbS/e2nx+AG4Fm7X5nO/QDrHhVh4
         eA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xi4pieaWpB9ZbQGECXfNGW95Le7Of61cqOGJzReDeS4=;
        b=ncGOxRaUH0ZWl8hMhbiVrxKG8gPzwMaZwyd65SiXmJ3zGmLFeAQ8/T9+6KkSWY7YQA
         z5CANvyAe1dgGijiYHm1cz82vNOkbVmpBZMIlsPv3fnUuOLDBUTDifO68UaIiaILg08Q
         BQ2RpcKESY0nCbj2W29h1gdMvbsHv/LbU9z7lMcqrjEvPdZ+lYn4EKXbrdBKrGM0Eb8B
         EKpnUJMmP1ACmiOpCi2rnkqGf4Bzk9ub4UFHk2mDLMN1m7TXu2UyJrYZo5sFow8BNF7+
         4THw4PuSMRjGIavsqcPv00DA/gOCofBe/J8pa4hwcG98CHzd8hCfTVxdlHRRbNvpFrOa
         siZQ==
X-Gm-Message-State: ANhLgQ2dOIotXvPCr3uI7Ea8Fz1ki710jLoK9vTHAWOTFGYiHXti4K7K
        wPWUXnpCOb3T3LEX9NK9l+Lf2GctiP1wbmwT23E=
X-Google-Smtp-Source: ADFU+vus2+FaLYDlyzytykbfnykOV4jRTCAhCGDfcqyz+sOVmLKx1cADfrGET6owaKj27XmbTWozfybX7ooKGBXByug=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr3829193pfs.36.1585392121778;
 Sat, 28 Mar 2020 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <5e7cce84.1c69fb81.433c4.751d@mx.google.com> <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
 <5e7f1f28.1c69fb81.33271.73d7@mx.google.com>
In-Reply-To: <5e7f1f28.1c69fb81.33271.73d7@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 12:41:50 +0200
Message-ID: <CAHp75VeZMccYGEqH7Och+hQO8DsNGWce+RN-o3FL4diaB8c=bg@mail.gmail.com>
Subject: Re: [GSOC] Choosing a component
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 11:56 AM Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> On Thu, Mar 26, 2020 at 05:13:24PM +0000, Bogdan, Dragos wrote:

> > The IIO community can also suggest an Analog Devices component.
> >
> > Rohit, anyway, since the student application period ends soon, you can just think of one component type (e.g., ADC, DAC, etc.), create your plan accordingly and submit your proposal.
> After doing a search through ADI's website, I chose the accelerometers
> ADXL35x series (ADXL355[1] and ADXL357[2]) as a component that I could
> write a driver for, having verified that there are no preexisting drivers
> for the same.  Hope this is a decent choice.

Good choice, though one recommendation before you start.
Check carefully that these components really need a separate driver
(instead of extending existing one). In the kernel we have enough
examples of duplication of the drivers by various reasons.


-- 
With Best Regards,
Andy Shevchenko
