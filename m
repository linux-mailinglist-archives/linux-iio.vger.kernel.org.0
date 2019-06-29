Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3F5A983
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2019 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfF2H52 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Jun 2019 03:57:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39630 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfF2H52 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2019 03:57:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so7749497otq.6
        for <linux-iio@vger.kernel.org>; Sat, 29 Jun 2019 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rSafS8mJiVYg68ctT+ken8ftV6c6iiOWShluV3Wyj9g=;
        b=pExPxwVZiWlUwpZgGE6L+Xo1Jz4F0Tf4wXQO88FwhAzlcKivzm3Iu1q6wiHskB871E
         Q4sLm1g49yIx4GvgugrSYCU9srAlZuAay+OET7gAhjNdNXNj0cZg2yzVa05Ik3cywqgK
         /hTJo1ilqpoGTkxEP9+0Xfg5lISf1hK5qRYJ9M/UpQ2UpDEy6RLEO7zMjhFi6mzIKEwN
         lAxeA/Ygsx1Dbd5hHxp+m5o3FVwhNENrac6ZPN4uR1lmJ4JHUar60UvIEwp4MDtOqLRz
         3YXyqAOKSz0y7Bnu4SZTnKvru8fu7XMgw2yhwaXwT+ROKOL0iI5aegFJfJFJ0+ch+X3P
         4vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=rSafS8mJiVYg68ctT+ken8ftV6c6iiOWShluV3Wyj9g=;
        b=SqnhdiyxUOsXeaM0mbxdJFYsPIU4T/+qVuYzqxJqJRnUa1p2DwvW7F29QBuBZd5yMM
         JgIXHpIUZP5dzLODv/hql6PlDRqY3r81h1Bl5kN2rb/qJf8kxZUIbu40B66lWBM2dPSP
         e140aaJHGPs6fg+iOBYTG5Ji4AurQQkGKwIjallbkJ/weg5cyLAKE1Yn0RirpCAGQg9F
         Fnjmbrdnf5mfZC9KSwOfEDZiDF8FJv/03m/8kXqBxB8W4vNMog7YO+Q+dQjtQKjctqf5
         /fTXf78WZAlFtyhv7+/vPgzDR8wvA/CHosU4F5HXtasXG7AVsb4LEnvSpp5j7G1hI4/s
         0vqQ==
X-Gm-Message-State: APjAAAXdxO4CC+GQtAfcWXFVx8Sxr+W3+2ze508Sicg9lALqKkwCcoUy
        XieR8/TMR+LTg83IdC6tS+EiXltCLTc7UhHsS58=
X-Google-Smtp-Source: APXvYqziVrRKm3Vng5h7ZHi9eBEx8zvrGF2UwPAA80GzWk+ILqsOZCxp6w2ARXiJgKfDUxu0m3Qae3/DiDfGliQ5w84=
X-Received: by 2002:a9d:2c26:: with SMTP id f35mr11281593otb.362.1561795048064;
 Sat, 29 Jun 2019 00:57:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:58ca:0:0:0:0:0 with HTTP; Sat, 29 Jun 2019 00:57:27
 -0700 (PDT)
Reply-To: nazfasari54@gmail.com
From:   Nazira Sarkis <tonydurrant404@gmail.com>
Date:   Sat, 29 Jun 2019 08:57:27 +0100
Message-ID: <CAL-uh2KV-hFRUa=aGXLNPHJxbLPQzgkWvF6U3A-pv3y1=-xW-A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=20
Greetings,

Please do not be offended by my message. I=E2=80=99m Mrs. Nazira Sarkis, th=
e
Minister of State for Environment Affairs in Syria. This is the 7th
year of the civil war in our country. My people have been passing
through extreme difficulties, so much shelling, killings and people
taking horrific risks fleeing to other countries. Some of us that are
still working with the regime are being forced to do the job. But now,
I have made up my mind to leave and escape from this hostile working
condition since I have gotten enough resources I can start a new live
outside Syria. The only problem I have now is to get a reliable and
trusted friend I can send the funds to for safe keeping till I come
over.

Please, this is a highly confidential proposal and I will appreciate
you keep it to yourself alone for my security or please kindly delete
my message and never reply if you cannot assist me, but kindly get
back to me on nazfasari54@gmail.com if you really want to assist me,
and I will give you the full details after receiving a strong positive
response from you.

Yours Sincerely,

Mrs. Nazira Sarkis
