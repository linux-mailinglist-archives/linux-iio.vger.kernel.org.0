Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06912DF3F7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJURQD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 13:16:03 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42937 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURQD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 13:16:03 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so4651886ilq.9
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2019 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDDusCJCrTMEWx9uUOU4sUpxfKkOpL87Brxi2v+/7T8=;
        b=ZS5+9g90sp9mtEhsLeSCsdXdtG0gD7fLx9/M5gyAVt9do+k99KPnl/IB0lTIIcvFda
         FKPPcxjWo5WcfZTyWJy2jr7F7kGSp/baCYi1fKvhc7Q5Dsr7KPvw172CAwGqxmLANFki
         rUgjeUA3E4A+2CZde6eDdP0W2IHO0zGmgYtbGdNEZwfE/wik+rwdamnafhke6ewl8cVY
         GAgisff0vOiJVnnjNpg3ms+t9TJqkf/zAkMbpmHM1S81CCullUFF65j141f8gDB6Xlst
         xBZD9WUwCPQiuiIQnaJm6dLCbTAk0KoLXNsq0ZeGICMQ0XTSewcE4JxPA1ZuFPP2Twht
         nbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDDusCJCrTMEWx9uUOU4sUpxfKkOpL87Brxi2v+/7T8=;
        b=azv0erWdkfAxt9/byqwfdl06coIvKkur048IEMe5tybvTvLCdtxR7hCId7LGS8N4EN
         exG3LI/Hv2udckVNMv5SnjQIy6w2wrZYSBwA0hLZIbudrJv5d5CD7fDGf4YmZFlnrTX3
         CR+49F1ComCdnd0KVEivsXK34nVjSGL/IuixfSKoUcHvWBJxSOrabxitEv59XpqIl+fh
         qHrKI7NeLvKKHn79YgNAhEQNBCLLtWytL8OaDFEwxLoIrWB6uT+9kH4t0o5FYQ0LBSLf
         qBbPZyCwjWBPBzIHkjxZQ3KjrEw5seUxUxKErYgymC9Ccm9R3xJ4tsLGk+CC5cAXa5Mm
         2TCQ==
X-Gm-Message-State: APjAAAXoKeDjUZ/bFoxYJKCItvfbi+iCoV4J5E7pvfDeAX3a4qVjAFEi
        N/AAsgxZCQhneyxIM/gkkIDflh3pIus4BT+ESH1WeQ==
X-Google-Smtp-Source: APXvYqw/r3cw9wHVD/RltakAaUes+6GlTcdOa6+YiFBTc3rMsGD7htWqHfb0BWmmVHA3xkkWjs7by79vOMMacj/xyxs=
X-Received: by 2002:a92:6701:: with SMTP id b1mr25750053ilc.181.1571678161960;
 Mon, 21 Oct 2019 10:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191010175648.10830-1-rjones@gateworks.com> <20191014184921.22524-1-rjones@gateworks.com>
 <20191014184921.22524-3-rjones@gateworks.com>
In-Reply-To: <20191014184921.22524-3-rjones@gateworks.com>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 21 Oct 2019 10:15:51 -0700
Message-ID: <CALAE=UAN=JXMo59-6Cm_wLx1qdiQ4VBpbkSMUsiUP7cLiiZQ1g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: imu: Add support for the FXOS8700 IMU
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Just wanted to check to see if you had gotten a chance to look at my
response to your questions and the following submission.  I was able
to get a reviewed-by from Rob on the device tree bindings, and I have
some free time to work on this if you have any feedback.

Regards,
Bobby
