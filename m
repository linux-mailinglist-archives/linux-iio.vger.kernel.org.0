Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7FE645B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfJ0Q5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 12:57:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727237AbfJ0Q5e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 12:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572195452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0UgV3lT7kjp68nqTUQLv1IWHForOi5FfkcspwLJWPQ=;
        b=KVkdp4qxCEozM27kHO63NYZWseTN5YgGfB4Qe6CeAAugFY927qIsDWBAVmZPp+oJZRlZRV
        jR0FfrMt7YRYyUtQniLST5WloDfvAx7H76SSRB3YjZOo2A1yG/7uRmq+3casQAVPcrLwIg
        FbPffa37SV7QqS+M0XBiXa109KVmxAg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-Ekd01tsIOs2-PsjkC9Vb7A-1; Sun, 27 Oct 2019 12:57:31 -0400
Received: by mail-io1-f72.google.com with SMTP id g24so5779625ioc.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 09:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiyGHBoRq5Dv8+7cLKe9dCEaHNIIIeUJ6r+ZGsY4CZw=;
        b=aZS0l5A9mz0C4bd7Qp9jGH164QRDT7uR/sePtGBh0PKJwxUJNsJBs5Qt3q3N57XWvt
         qoxVNbBh+gmA2j0/ETjOOms+fX0o8B6aR9XdmWCyluJso/RimTadRTyoXg4o0gSORH3Z
         py0zoFF7kTU6NcqZAxMIDa97AnP+mfEfUQwk+f1cuq4vG3PcKOQaUIvLYWhpzb3uBkP7
         Jc0rRhhszn1Cnxcd3SzdiawUHTdby2jHXI6vFruu/CAYxUup/jN1LnYZxwXaPc2NAO5R
         2+ECyjEaH6w5XWV/8MkBbhuvl5xT7V2nMl7S0KKMnpQkEWSdxfBtOodQAEnCnfwr26SN
         y4/Q==
X-Gm-Message-State: APjAAAVwvqVCslPe+nRKi0vnGg6ZLYelq1a+W4Pl6SxQ10bX4Aq1BMhk
        1tsPp3jxin8q4kkK+m5Mm+TC13rr2WdYVso9T1ccsuQMORL+QDf8DbB5PNS1lWrnaqHaj+zAPVk
        6jaOnjyEfmMdMGtUbwi9fIh82ZVfI95zwJzF0
X-Received: by 2002:a05:6638:23b:: with SMTP id f27mr4267244jaq.55.1572195450875;
        Sun, 27 Oct 2019 09:57:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5CLYZpxKjYU/Dulf+5fc0vZxxdn46JVSt0bEdgtord9iYUnQmyhJkuYYJr+Su4agJmXOKWN843O0zpcrsu9A=
X-Received: by 2002:a05:6638:23b:: with SMTP id f27mr4267231jaq.55.1572195450562;
 Sun, 27 Oct 2019 09:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571931470.git.lorenzo@kernel.org> <1e96ac17ca6819cf8f35c757a63e11e815455225.1571931470.git.lorenzo@kernel.org>
 <20191027164024.685c1ced@archlinux>
In-Reply-To: <20191027164024.685c1ced@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 27 Oct 2019 17:57:22 +0100
Message-ID: <CAJ0CqmWRVcd=VwBpVsbDVsqiQetVULtgHJG3KxQJA7aQZ4EJKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsrx
 device bindings
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
X-MC-Unique: Ekd01tsIOs2-PsjkC9Vb7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Thu, 24 Oct 2019 17:42:34 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Applied.  If you get bored and feel like converting this over
> to yaml at somepoint that would be great ;)
>
> Thanks,

ack, added to my ToDo list :)

Regards,
Lorenzo

>
> Jonathan
>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b=
/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > index fc018ecba086..cef4bc16fce1 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >    "st,ism330dhcx"
> >    "st,lsm9ds1-imu"
> >    "st,lsm6ds0"
> > +  "st,lsm6dsrx"
> >  - reg: i2c address of the sensor / spi cs line
> >
> >  Optional properties:
>

