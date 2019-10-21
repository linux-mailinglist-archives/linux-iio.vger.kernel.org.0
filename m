Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6219DF415
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 19:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfJURVz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 13:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfJURVz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 13:21:55 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09962089C;
        Mon, 21 Oct 2019 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571678514;
        bh=SYpEJFKUcvPNj9+4z7rqcb97NEcogWIgV/xCLMMUywA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J2jFrgIpGxKvd9FIYb/VEJ2WbLxM60E+iDmd/iS9GY0aHlz/ZWJJdv/8z3l+BKGjx
         4dVqDQviALL8gIemyeo5ZZcvVAkK0RyiXfAXenF69xI0iGvolq45dtfla6jucjXVun
         /FkYMR6C5BZ0x9AYOyd3DtWt6swxKZ56fd7bF6+o=
Received: by mail-qt1-f177.google.com with SMTP id z22so1668623qtq.11;
        Mon, 21 Oct 2019 10:21:53 -0700 (PDT)
X-Gm-Message-State: APjAAAUI1t3ScOdymf3QheMQjdkyAhKTNrQ/TywIYJW9p7skKE/SmOfu
        u7e77qvwtcPMnCFj0OejDRm7VkmoUkUtlJIXJQ==
X-Google-Smtp-Source: APXvYqz/KkdnRA0X14PgdTwtIDdgEw2A0RnxTw/n5AHCYfwxEFm6jj/LMEjFYqOQCAXfF6HFdnHPV3STLDKP4fJgJ3k=
X-Received: by 2002:ac8:4508:: with SMTP id q8mr9885446qtn.110.1571678512972;
 Mon, 21 Oct 2019 10:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191011084038.45829-1-nuno.sa@analog.com> <20191011084038.45829-2-nuno.sa@analog.com>
 <20191012115745.069119b0@archlinux> <20191014143950.GA6163@bogus>
 <CAL_Jsq+Hju1KtvfjEJNGsS9maC3LDn0FcQJe6Wp+y-YgiAP=+w@mail.gmail.com>
 <20191015214435.5d51835a@archlinux> <20191021162736.7409baa7@archlinux>
In-Reply-To: <20191021162736.7409baa7@archlinux>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Oct 2019 12:21:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5SYOPDOJJJ8+OuGpQ=PKB2JmbQ=yGN1fyuZnuQnAJ2Q@mail.gmail.com>
Message-ID: <CAL_Jsq+5SYOPDOJJJ8+OuGpQ=PKB2JmbQ=yGN1fyuZnuQnAJ2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 21, 2019 at 10:27 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 15 Oct 2019 21:44:35 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Tue, 15 Oct 2019 09:19:10 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Mon, Oct 14, 2019 at 9:39 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Sat, Oct 12, 2019 at 11:57:45AM +0100, Jonathan Cameron wrote:
> > > > > On Fri, 11 Oct 2019 10:40:38 +0200
> > > > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > > >
> > > > > > Document the LTC2983 temperature sensor devicetree bindings.
> > > > > >
> > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > >
> > > > > I'm happy with this, but will be waiting for Rob to have a chance
> > > > > for a final look before applying.
> > > >
> > > > LGTM, but I need to add the int64-matrix type to the core schema fi=
rst
> > > > or this will give you errors. I should get to that in the next day =
or
> > > > so.
> > >
> > > Now added, so please update dtschema and check.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > /home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temper=
ature/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-th=
ermocouple:0:0: 18446744073659331616 is greater than the maximum of 9223372=
036854775807
> > /home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temper=
ature/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-th=
ermocouple:0:2: 18446744073679351616 is greater than the maximum of 9223372=
036854775807
> > /home/jic23/src/kernel/iio/Documentation/devicetree/bindings/iio/temper=
ature/adi,ltc2983.example.dt.yaml: ltc2983@0: thermocouple@20:adi,custom-th=
ermocouple:0:4: 18446744073704251616 is greater than the maximum of 9223372=
036854775807
> >
> > Which is odd.  I haven't looked into it beyond testing and reverting th=
e
> > patch as out of time for today.
>
> I'm still getting this and not sure why.  Rob?

Just realized I failed to send my draft...

This is dtc yaml output not maintaining the sign, so everything is
unsigned. (I had mentioned this and then promptly forgot.) I'll need
to figure out how to plumb this thru dtc. For now, its probably
easiest to just change to uint64-matrix with a comment that it should
be signed.

Rob
