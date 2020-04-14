Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DDA1A89FC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504251AbgDNSn7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730222AbgDNSnz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 14:43:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A60C061A0C
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 11:43:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k21so738905otl.5
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I+hAlgTR2YEuEasOcuEwhqs57QQeHXfYQ3rgmaEJ3/A=;
        b=YkvaGV3/zX8twiwwxX80m20zglEvh4BB9vxIlM3cb5IxMaJ8iFlZKMiXo9XhR+v1pt
         GSNbJwc7ZDAv1T3/azo7hSx9f9livxuY4tNPa5S0g/LrAX/jHD17IU5YBT4gpgyqT3Zj
         MXZrlT3v6joSx1T+5NUuHvPhbEa8QYPWLQLVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I+hAlgTR2YEuEasOcuEwhqs57QQeHXfYQ3rgmaEJ3/A=;
        b=MNIRy0AKuym4It/pZZNx+opUUr7qFlbtHua6J+Nd6TI/vJMXNT1CHITm/3odW1I/yg
         N0OKfUrTV0QAXgRNNswv06KUReeUlfGi8yPzTF2ji6BKjCjfKFzt0bxQDcE21kLqOEb0
         V6uJbsdvVQm0t/jm/hN+YbxXoktL/O2oANHBe+9cfJD3JrT5txSvX5ghyAqizNmO4BX/
         3UTZ97xSLUV3+xbp2RYXG/12tnxbMUE7iqnD/1UqeyUxLIrXqNNcT0Cm1phJV4orp2Xw
         2Jxv29fKPsvb8bncLdPsYlvStEbpO1xd0kOslPq5512v51QmdnD0V5kNItrWGR32rpmn
         t3hw==
X-Gm-Message-State: AGi0PuZ5JAWiK8ijd41qMa1WbC4yfclQoM/gOT2vJ3R5HnS/TKEG5Kiy
        WqOlOsSkKkPeZJrQj9BBTDW3WhjkT1lygP6CH6m9Gw==
X-Google-Smtp-Source: APiQypJzk2/mOjgpezw5X6Z56heQTR1kDjxxReCnKT5erKGVfXruFF680EWRItJ3VGnfYO4jvO8WnLRL0KusdyidAS4=
X-Received: by 2002:a05:6830:18e:: with SMTP id q14mr9504903ota.136.1586889828619;
 Tue, 14 Apr 2020 11:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XPV5MX1aH3yMcRmukmOU4cPFL34dFfPoznwxGT6cTeqYSTvg@mail.gmail.com>
 <02c6aff918a4cda27f2f16d852a9e52a81fbce5d.camel@analog.com>
In-Reply-To: <02c6aff918a4cda27f2f16d852a9e52a81fbce5d.camel@analog.com>
From:   Lars Engebretsen <lars@engebretsen.ch>
Date:   Tue, 14 Apr 2020 20:43:37 +0200
Message-ID: <CA+XPV5OCMccsZe0iiQsXc-5N2qBmgpjsuTHvDT4yrJhSfXXF3A@mail.gmail.com>
Subject: Re: Small error in iio/iio.h
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Den m=C3=A5n 13 apr. 2020 kl 11:04 skrev Ardelean, Alexandru
<alexandru.Ardelean@analog.com>:
>
> On Mon, 2020-04-13 at 10:38 +0200, Lars Engebretsen wrote:
> > Hi all,
> >
> > I just came across a small thing: I think that there is an erroneous
> > semicolon at the end of line 603 in include/linux/iio/iio.h
>
> yep;
> good find :)
>
> >
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git/tree/include/linux/iio/iio.h?h=3Dv5.7-rc1*n602__;Iw=
!!A3Ni8CS0y2Y!rXR19w3XDkuxpdAY4teDN4bSsfqvea7Sz5ZW26L2TCEeYhwf1mgTjt63tIp3X=
ld9oFWgcg$
> >
> > I'm completely new to kernel development, so I don't know the process f=
or
> > submitting patches. Moreover, the macro seems to be gone in git://
> > git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git so maybe the issu=
e
> > has been fixed already? In any case, I'd be happy to submit a patch if =
that
> > is the right thing to do. But then I'd need a bit of help to get starte=
d.
> >
>
> You're probably looking at the wrong branch.
> It's a good idea to look at the ones that have been updated more recently=
.
> It's still there.
>
> Check 'togreg' or 'testing'.
>
> I suggest editing those.
> Look for patterns in the commit title & descriptions, don't forget to add=
 your
> Signed-off-by tag with  'git commit -s'
> If you want, an idea for a commit title would be:
> 'iio: core: remove extra semi-colon from devm_iio_device_register() macro=
'
>
> Add a comment describing the change.
>
> Generate the patch with:
> git format-patch HEAD~1..
>
> then run ./scripts/get_maintainers.pl <patch-file>
>
> The output suggests which lists to target.
> What I do, is put lists with --to=3D<list>, maintainers [other people] wi=
th --
> cc=3D<maintainer> --cc=3D<driver-author> --cc=3D<other-potentially-intere=
sted-people>
>
> You first need to configure git-email to send emails; there should be som=
e docs
> on the web about that.
>
> Lastly:
> git send-email --to=3Dlinux-iio@vger.kernel.org --to=3Dlinux-kernel@vger.=
kernel.org
> --cc=3Djic@kernel.org <patch-file>
>
>
> That's roughly it.
>
> We should see your patch on the list.
> https://lore.kernel.org/linux-iio/
> &
> https://patchwork.kernel.org/project/linux-iio/list/

Thanks!

I've sent the e-mail now. Got one address wrong the first time, so
please disregard the first e-mail. :-)

    /Lars
