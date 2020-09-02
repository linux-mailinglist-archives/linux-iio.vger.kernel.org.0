Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4864425A813
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBIwv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBIwr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 04:52:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58610C061244;
        Wed,  2 Sep 2020 01:52:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so1967066plb.12;
        Wed, 02 Sep 2020 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5kK6Wa2EiA8NHptvj4DdfbhcaDVH2VnHPRJxPmhabs=;
        b=b7kETiouwJ153YPVInR5Q1rNs+RB/u2YtTWsd7rePfstwn6Z3cExVJ1qeUKG7nlogE
         UI8I7EMN/Z0rM14ZieXpbkXzSQMvfbvuEm+1nRuRNn+3zVPdTNY1ebSu88A8Ha7bTZpt
         s5Lzfzl5T7tF5+JFEdS7WRosBSF+UHLvnHlxJrGp9u9CwS++61yXo8/pEm3Qd6HAsVMC
         6mVMzgOsLPJzdF1l8ylFRrtD2oJVelOj1sng0Ze9o84M3mBCpk7g0XMas4p4pG2pVpYZ
         1rX3kQoYBjF2UpeJDboewgnG8c8kMQbyweS1VVdCosXFDHoCBhYzKg85hlFAPlybrM+r
         G+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5kK6Wa2EiA8NHptvj4DdfbhcaDVH2VnHPRJxPmhabs=;
        b=QsbhbxiTwRaEMDoI7i9E0dZ3Sdg7a2tTV6kWTk3mPlKK5ao+j324QV0LLlg0Zw2QnR
         YvYin10vc9tiop05YKSGgcQZMM37+wPhUmqpwOfalH2hus0Ga1xnRNiRz7uq5+jOBSXb
         w80OebjaCxOaStZlMVpUzUg/vBKS3JH3lpsI3VlnfwtQQylOozRKrYcZV4lHdyYks6Q+
         s/rDkpeFpc2Nsk+zX5aUq2k3vRQ99z+oMjmgguMtmn8PQ+jEjUXeGS1S8QRuKpcOgG0B
         JnXy+7ugsd3WLY3epmhmgP13TM0jzTv82AKj8Glzy8c5Zld0DGq42NsQrHzWJyDVyOui
         sktw==
X-Gm-Message-State: AOAM533EMmVjH0IoiKhYTVRWoUtw5B8o6zQtnTm1i5ySgRm4ijuKuCfA
        br1GAhjJ5nBnYgOgzKJQryMhk2GgGahFeA2mlpc=
X-Google-Smtp-Source: ABdhPJxkPxK6trSlnvLhkEo/gpXsPaxPq+zOvuJ5Z0Z1qNTtmQ2HGXwCVkoUiBr1B8I5XxZq0RiYUf7gF9GyRgUB48o=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr1407120pjd.129.1599036766868;
 Wed, 02 Sep 2020 01:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com> <BN6PR03MB25968259EBEAD55E040367308E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB25968259EBEAD55E040367308E2F0@BN6PR03MB2596.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 11:52:29 +0300
Message-ID: <CAHp75VdvnUsEf=fsRQRmyxQO=1m09M5U19GBtSPkjxSGA5cRBA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 2, 2020 at 11:09 AM Hennerich, Michael
<Michael.Hennerich@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Montag, 31. August 2020 14:46
> > On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao <acelan.kao@canonical.com>
> > wrote:

...

> > P.S. Jonathan, it seems this driver has artificial ACPI HID. We probably have to
> > remove it. However, ADS is indeed reserved for Analog Devices in PNP registry.
> > Can we have AD's official answer on this?
> > Cc'ing additional AD people.
>
> Agreed, this ID was chosen under the PNP ID Vendor Space for Analog Devices Inc.
> Days back, I did a quick kernel grep, and there are many drivers which use the 3-letter
> PNP ID as acpi_device_id. So, I thought this being not an issue.

No, no, the use of PNP ID is not an issue. The point is if the ID is
artificial or official.

> I'm against removing it since I know people shipping this in their ACPI tables already.

I see. Can we consider this email as the official answer from AD that
this ID is being allocated for this certain component?

> Regarding ACPI DSD customization, one way to do this is to move this into the BIOS.
> This way the particular piece of HW can be customized rather than manage HW
> connections in software.

Assuming the confirmation on the above, indeed, one may use ACPI HID
with DSD properties in the firmware. Main purpose of PRP0001 is the
*development* stage of the product at which a vendor should take care
about allocation of proper ACPI IDs for the components in use. Yes, I
know that this is not always feasible b/c some HW component vendors
don't care about ACPI at all.

-- 
With Best Regards,
Andy Shevchenko
