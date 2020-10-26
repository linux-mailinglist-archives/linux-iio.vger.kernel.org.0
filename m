Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB7299295
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1738342AbgJZQha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 12:37:30 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:43785 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786152AbgJZQh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2020 12:37:29 -0400
Received: by mail-vs1-f52.google.com with SMTP id d19so5155599vso.10
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2020 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=biomason-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3Hck3a6BIWGwizweVFBqwCVjlHbodjM+1TumEZ54DPw=;
        b=0vWA7enscw71IDvxYj2s3PdMUGjw8hHfgfYNO2iP3x5GLWytICPH0HqI/xXJnLkS1n
         VsalUjkosSyDus0KjT/Cjz6U6N6s0aENm9AaacW/hI9hc94OZvvm4LQc80UquRibkSQ8
         pw2/9tnksBnBeaDOk3YJqUNefcZqnVKNfTmEb6irl2+NiN2q9UzgTgYtX5HkUAwPYP3h
         ZMqvvTRp1s+iUCX91lm1S5aUBoBBTBR+hxu+luywmtOByuM6l6rIzoG8uXrrOL2xy2EL
         kagkHKZq77txQggPx0BhzvtXZQMGPI8XJH42tHT+JuTEXWtxhIzfZ1JpVFW2KF+SgMU3
         qwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3Hck3a6BIWGwizweVFBqwCVjlHbodjM+1TumEZ54DPw=;
        b=XUsbtHxCcdomODiW9olN1edh8bCJc5a7Tfkv+oFUIUGEe9xLWYORnEp0r0s7sas11S
         qeF6PHFsSheOPL7b3tFGvBcN6b8RT1Gk5wmPaICkVWvguJ8tDgUL5gVH2Qc7ahLw/tVQ
         VNwg4ReR/007r723yMdfzRozouY2g1MzqaVkqXf2f9mqA2PK8mKrvD1eFixwRd1rHEXQ
         5WS8aw66ub3EOiXFQQBVpKam2r4We4/wxPmiQ5Z7eRAsgDXIIKqIdANQQo62mQ9YiuFD
         v+IdUo4GyRBR/AXPNkgxf4g1ld3raDlZiiECmqMImzzMvVeweldMoAwj4hvkeQ5qg8AB
         F4uQ==
X-Gm-Message-State: AOAM533eJ+Zlhr32q5kWY/rqPKVdOEonLaVqzX2yVlzQbTc196Rda13a
        fySKQ78mMf3iUjLl84qWuy15QaXe5tRL4J7q5REWZOFABnTh4+IGrO4HBxP5tScdxmJiOeJdmLR
        o1Y8Rf7ivl61SsqyMwOwWsMzsQyaRnmXsLG5JtT3Z
X-Google-Smtp-Source: ABdhPJz3Fs+h19amPwQmXYXQF03hGmsQVz+gqWTGYBuUQR3tedOKXcrYT3rVTTSp4buWKUtvo7cbZe8tf96z4noFfv8=
X-Received: by 2002:a05:6102:349:: with SMTP id e9mr22582153vsa.36.1603730247670;
 Mon, 26 Oct 2020 09:37:27 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Wyatt <matt@biomason.com>
Date:   Mon, 26 Oct 2020 12:37:24 -0400
Message-ID: <CAJyU85OXRWuVdFhTB7jdp=ggBDDmGTiQ-CahWbw_6cYrGUF5Ew@mail.gmail.com>
Subject: Linux Missing IIO
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I am using a Raspberry Pi 3 and I am attempting to set up an ADC to
the GPIO with I2C. I am following this
tutorial:https://wiki.seeedstudio.com/4-Channel_16-Bit_ADC_for_Raspberry_Pi=
-ADS1115/
for setup and the iio kernel seems to be missing because I cannot find
the directory when running cd /sys/bus/iio/devices/iio\:device0/

When running lsmod | grp adc I do not see anything related to iio
either when the tutorial shows as such.

I am new to this and would really appreciate some help!

Thanks!

--=20
Matt Wyatt
Manufacturing Systems Engineer
matt@biomason.com
(703) 474-0933

--=20
bio*MASON*=C2=AE



*This message contains confidential information and is=20
intended only for the individual named. If you are not the named addressee=
=20
you should not disseminate, distribute or copy this e-mail. Please notify=
=20
the sender immediately by e-mail if you have received this e-mail by=20
mistake and delete this e-mail from your system. E-mail transmission cannot=
=20
be guaranteed to be secure or error-free as information could be=20
intercepted, corrupted, lost, destroyed, arrive late or incomplete, or=20
contain viruses. The sender therefore does not accept liability for any=20
errors or omissions in the contents of this message, which arise as a=20
result of e-mail transmission. If verification is required please request a=
=20
hard-copy version. bioMASON Inc., PO Box 110345, Durham, NC 27709,=C2=A0
www.biomason.com <http://www.biomason.com/>*
