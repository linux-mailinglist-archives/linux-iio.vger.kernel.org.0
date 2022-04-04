Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B44F1B6E
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379637AbiDDVUT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379012AbiDDQTV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 12:19:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3119E31922;
        Mon,  4 Apr 2022 09:17:24 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXG8q68hXz687G4;
        Tue,  5 Apr 2022 00:15:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 18:17:21 +0200
Received: from localhost (10.81.208.76) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 17:17:20 +0100
Date:   Mon, 4 Apr 2022 17:17:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx
 device bindings
Message-ID: <20220404171718.000021fc@Huawei.com>
In-Reply-To: <Ykq7XW5lZtV7YNuJ@lore-desk>
References: <cover.1648893892.git.lorenzo@kernel.org>
        <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
        <20220402171753.638e71d5@jic23-huawei>
        <Ykm1s+8lCslxc80e@lore-desk>
        <20220404102258.00005128@Huawei.com>
        <Ykq7XW5lZtV7YNuJ@lore-desk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.76]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Apr 2022 11:33:17 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> On Apr 04, Jonathan Cameron wrote:
> > On Sun, 3 Apr 2022 16:56:51 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > > On Sat,  2 Apr 2022 12:09:30 +0200
> > > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > >     
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>    
> > > > Hi Lorenzo,
> > > > 
> > > > This runs in to the same feedback that was recently had for
> > > > https://lore.kernel.org/all/?q=Add+support+for+ICM-20608-D
> > > > but in a more extreme sense as this one presents the same whoami value
> > > > as for other sensors already supported.  Things are made more
> > > > fun by the fact that sensors with the same WAI seem to have different
> > > > features (presence or not of a sensor hub - is there any documented
> > > > way to detect that?).     
> > > 
> > > Hi Jonathan,
> > > 
> > > if we consider only the features implemented in st_lsm6dsx, asm330lhhx
> > > will be 1:1 compatible with lsm6dsr or lsm6dso, so we can just use one
> > > of bindings in this section to support it (the only side effect is it
> > > will be listed as "lsm6dsr" or "lsm6dso", but I guess it is ok). Agree?  
> > 
> > If the part has more features than the base compatible (or a different WAI)
> > then we can definitely have a backup compatible for it (hence making that
> > subset of features work on an old kernel).  We still want to introduce
> > the new compatible so that we get the name right etc going forwards and
> > are in a good position to add the extra features if we ever get around to it.  
> 
> ack. I did not completely get what you mean here with "backup compatible".
> Do you mean:
> - use "st,lsm6dsr" for asm330lhhx on older kernels and add "st,asm330lhhx" on
>   new ones. Do you have any pointer on how to document it?
Take a look at the mpu6050 patches. 


 properties:
   compatible:
-    enum:
-      - invensense,iam20680
-      - invensense,icm20608
-      - invensense,icm20609
-      - invensense,icm20689
-      - invensense,icm20602
-      - invensense,icm20690
-      - invensense,mpu6000
-      - invensense,mpu6050
-      - invensense,mpu6500
-      - invensense,mpu6515
-      - invensense,mpu6880
-      - invensense,mpu9150
-      - invensense,mpu9250
-      - invensense,mpu9255
+    oneOf:
+      - enum:
+        - invensense,iam20680
+        - invensense,icm20608
+        - invensense,icm20609
+        - invensense,icm20689
+        - invensense,icm20602
+        - invensense,icm20690
+        - invensense,mpu6000
+        - invensense,mpu6050
+        - invensense,mpu6500
+        - invensense,mpu6515
+        - invensense,mpu6880
+        - invensense,mpu9150
+        - invensense,mpu9250
+        - invensense,mpu9255
+      - items:
+        - const: invensense,icm20608d
+        - const: invensense,icm20608

Which ends up expecting

compatible = "invensense,icm20608d", "invensense,icm20608"
and will try matching on the first. If that fails it will try
with the second value.
 
> 
> or 
> 
> - add a "wildcard" compatible string for this kind of devices. Do you have any
>   pointers?
> 
> Regards,
> Lorenzo
> 
> > 
> >   
> > > 
> > > The only difference between asm330lhhx and asm330lhh is the former supports
> > > sensor-hub while the latter does not declare it (even if the use the same
> > > whoami).
> > > AFAIK there is no way to autodetect if the sensor supports sensor-hub and
> > > we can just try to discover slave devices connected. This can have some
> > > downside as described in the commit:  
> > 
> > Ah thanks. I'd forgotten this.
> >   
> > > 
> > > commit 35619155d044830357f06f1d2c8188c4530b4d7a
> > > Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Date:   Sat Nov 13 16:23:14 2021 +0100
> > > 
> > > iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
> > > 
> > > I would like to merge the sections in st_lsm6dsx_settings struct for
> > > lsm6dsr, lsm6dso.. and lsm6dsop, asm330lhh since the only difference is
> > > sensor-hub support. I guess we can have 2 option here to avoid any
> > > sensor-hub corner cases:
> > > - provide the "st,disable-sensor-hub" in dts to disable sensor-hub for
> > >   asm330lhh, lsm6dsop (need user changes)
> > > - add a bool variable st_lsm6dsx_settings[].id[] in order to specify if the
> > >   chip supports sensor-hub.
> > > 
> > > Which one do you prefer?
> > > 
> > > Regards,
> > > Lorenzo
> > >   
> > > > 
> > > > As such, we should really be listing this as compatible with one 
> > > > of the parts that is already supported such as the
> > > > LSM6DSR.
> > > > 
> > > > For that we'll need a slightly more complex binding and it would
> > > > have the side effect that if the match was on that compatible we
> > > > would list the name as whatever that part is.
> > > > 
> > > > I'm not sure that really matters a great deal, but it could in theory
> > > > create a userspace ABI change if we later needed to add explicit support
> > > > for the part due to some real differences not indicated by the WAI value.
> > > > 
> > > > An extension is whether we should relax the need to match on WAI if
> > > > the part is considered compatible.  I guess that depends on just how
> > > > compatible we think they are.
> > > > 
> > > > So I see several steps to this process.
> > > > 
> > > > 1) Add fallback compatibles for existing entries to first one with same WAI and
> > > >    same feature set.
> > > > 2) Add fallback compatibles beyond that to first part introduced with particular
> > > >    characteristics.  For this we'd also want to have the driver relax its
> > > >    handling to just warn if the WAI isn't listed for any of the parts that
> > > >    share a particular set of characteristic (so you'll have to loop over the local
> > > >    array again to check):
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c#L1197
> > > > Same argument applies as for the mpu6050 that, whilst we should modify that code to
> > > > cope, it's not a prerequisit for adding the compatible fallback to the binding.
> > > > Personally I'd like it to be the first patch in the series that modifies the
> > > > binding though.  Note it'll be easy to add the fallbacks for this new part as
> > > > no mainline trees presumably use it.  To 'fix' the rest we'll have to find
> > > > and update any DTs in mainline.
> > > > 
> > > > Note this won't stop us needing to add compatibles to newer kernels (at very
> > > > least to the dt-binding, but probably also the driver), but it should help a newer
> > > > DT 'work' with an old kernel.
> > > > 
> > > > Jonathan
> > > > 
> > > >     
> > > > > ---
> > > > >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > > index 0750f700a143..23637c420d20 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > > @@ -31,6 +31,7 @@ properties:
> > > > >        - st,lsm6dsrx
> > > > >        - st,lsm6dst
> > > > >        - st,lsm6dsop
> > > > > +      - st,asm330lhhx
> > > > >  
> > > > >    reg:
> > > > >      maxItems: 1    
> > > >     
> > >   
> >   
> 

