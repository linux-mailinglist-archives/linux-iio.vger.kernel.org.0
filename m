Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE037F7A9
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhEMMQz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhEMMQT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:16:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510CC061763;
        Thu, 13 May 2021 05:15:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m190so21209816pga.2;
        Thu, 13 May 2021 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2j2UW1qhghHj9R8VGG1rhJod30/9EcbT4gC1gcaS6Ss=;
        b=f0hMhnzssMAiRm4x3jpzv/HOGry6QOJ5XTtSUe9K0SATml9UU5oHDeAORc0G6HMF7J
         VrjSW5Mz2eLHClIwanRqaJndjLbwvBOBydw+YZfLUerHn6JNgjjKC2BSUHe3zYGAPjkb
         wHwmMi7HKQi6DtME+7+CLWhv6LqIsLnayiVwF3cZYoNNUJ47e/T2N44PSlZldTaNyRNE
         Kn05OJBpNFwPhD8J8Z5OiYjqInGNM+Hftr4TQ1TZMCvgrYVX/JNgJFF88fZBnPZLFitE
         JzbWJeJsm+nXsg4muNf0Yji6GVi2zeWaLxP0GQ+xd+h9M2W5MUnl/Cd2hydOxiBBUoCu
         ixXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2j2UW1qhghHj9R8VGG1rhJod30/9EcbT4gC1gcaS6Ss=;
        b=qKMcauO67cDpTUz4dERSiwGmc9BcEOml/+tDwyja1B2BzClQXZVW66kYs1pIU84hOc
         QYWA89QeLPFfeFAS8G4QKUpwIZlGZm7qVarglGQJHeAlbXW3RJRkRM+3px4xkbKT1HeZ
         YbSyvfGje972xvDjbTXsp5CCdZlPyCVAf+SUMj5LdLMdSjOi9OtbOM80gjG74I4FPr4p
         ZE6PbXyrdtKoHc4261ms21BRlKVENt/BS6CFjefBPO19B+0qWIMGYVn5aZkuT2UNaeL1
         1KNRuvCM6A5homlCLThtQgkSEC8zq/MhhkfLURq94rJjriDSi8cVP6qlrWOAmv14xyzo
         LX1Q==
X-Gm-Message-State: AOAM533kIuU0HkNElNRglDci7WzINtwjlGmZHDvF2Kw55NDHZEg4BmiH
        o99FPOCGVQcPNEwt7uX3FkMLhupVbsmV9lg+NNw=
X-Google-Smtp-Source: ABdhPJxsEXx7tzIDcFsgHnc8dgrr4KEO0LgPkv42Jlow3TG4MEmXSw1+YlzWao0F4Tj4/WJXWIigCRa8eKgMJZ42zzI=
X-Received: by 2002:aa7:954d:0:b029:29f:d9a6:63d7 with SMTP id
 w13-20020aa7954d0000b029029fd9a663d7mr37331180pfq.58.1620908108996; Thu, 13
 May 2021 05:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210513111035.77950-1-aardelean@deviqon.com> <a31b6d94-24cc-6f01-dc36-90c0001ea396@startmail.com>
In-Reply-To: <a31b6d94-24cc-6f01-dc36-90c0001ea396@startmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 13 May 2021 15:14:57 +0300
Message-ID: <CA+U=DsrSjQa-iL5FHyiwXN=Hv72jd5b99tzcNoO97ckXgiuGzA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: remove unused private data assigned with spi_set_drvdata()
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 13, 2021 at 3:06 PM Alexandru Lazar <alazar@startmail.com> wrot=
e:
>
>
> > Some drivers were copied from drivers that fit the criteria described
> > above. In any case, in order to prevent more drivers from being used as
> > example (and have spi_set_drvdata() needlessly set), this change remove=
s it
> > from the IIO ADC group.
>
> Oh yeah, I'm pretty sure that's how I ended up adding it in the max1241
> code, too. Code monkey presents humble apologies :-).

Well, I also added one in the AD9467 driver in the same manner.
So  =C2=AF\_(=E3=83=84)_/=C2=AF

>
> All the best,
> Alex
