Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77788400EEB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 11:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhIEJ5Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhIEJ5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Sep 2021 05:57:24 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD6C061575
        for <linux-iio@vger.kernel.org>; Sun,  5 Sep 2021 02:56:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so7409198ybm.10
        for <linux-iio@vger.kernel.org>; Sun, 05 Sep 2021 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=YZ506Of/RMoNlToT4sr1NoqZQVOGqE8odgx/NML/G7IDNXG+e+Y0o5ODgFG4BxcjO3
         nS3t31wSlZaNKcC0/QLV8AMMyoyak17gIXQ3ELxEmqgAmOcOrKkcvOO63s+lsFSX1Qfb
         VKI6py2+bc/8OxdqvWhAf4QDyAoKCJepliK8pMJanMge/7x4ObQGRxoCaOqBPE/FpL2r
         p389CYfG8jNCxAsXdqjtZRcd+C3uneRSlcmWFr7z36zCJceG53UAvUF8YedT7lCN5zJD
         TiraQbotFSspNFjzVV8uclDcJviVGO6vQx2c0AxAgCdVumFt70I7XweOX140lnRBaQUh
         IzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=Pro1SWZvqyhQsOWQyuq5QIuIl0k4LUv9MfKncJbv/v7htH3gyQmj+qrv0/ApXu57an
         QrcUXUCoYo+lk8YKPeIDHMUKn5qWb+S1QaMzplpFMadkkDlubrd6wr3LTu0ztD9ZXqEJ
         y26Q04IlKQk/gYEGWV3vwXLoy1g94fNIJwQms7QlZdD4PBmYaKkdGLceA5zSWKrLeKCt
         S0hiFkYNt/usFbJyxeDJMCdod7Hax6zOIhT1iRwcg1EQHXy0uK0fnQz/4WF26kJ8Gb25
         TNH06vxUCSdb6OTQksHUJgBuX5RodVzGocBHmBIoS8LwVY51zaxSucJeQqlo6CZUJ6EL
         DDBA==
X-Gm-Message-State: AOAM531WWfpHCGmOl9HiU6onNarJiavV+XnsyXNGgZ/yZiK2UcTOaeoH
        8UO+hk4F2voPtNu8nE9EOPL4/LTIY9q9cIFWHGWzWf+R+iBs0g==
X-Google-Smtp-Source: ABdhPJy2CoHfDkMSn2IT+ljIKlt4K0dESKHmi6QCc04kIAgb6HHPrVqa9BTahQh/LXfR6oCkb172KPZ+n5/RcGNg54Q=
X-Received: by 2002:a05:6902:150c:: with SMTP id q12mr6529089ybu.410.1630835781048;
 Sun, 05 Sep 2021 02:56:21 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 5 Sep 2021 17:56:11 +0800
Message-ID: <CAMEJMGH2-EqBAoAZyJsHtWimpfzHC7Oy33DJEqfRqCQo69nMSg@mail.gmail.com>
Subject: Introduction: I am a Linux and open source software enthusiast
To:     linux-iio@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Subject: Introduction: I am a Linux and open source software enthusiast

Greetings from Singapore,

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 5
September 2021. My country is Singapore. Presently I am an IT
Consultant with a System Integrator (SI)/computer firm in Singapore. I
am also a Linux and open source software and information technology
enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

"Autobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)"

Links to my redundant blogs (Blogger and Wordpress) can be found in my
email signature below.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books are also available for download on my redundant blogs.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
