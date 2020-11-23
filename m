Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD592C0FCF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbgKWQHr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 11:07:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2140 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbgKWQHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 11:07:47 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CfsSB6WqPz67G7h;
        Tue, 24 Nov 2020 00:05:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 23 Nov 2020 17:07:45 +0100
Received: from localhost (10.47.69.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 23 Nov
 2020 16:07:44 +0000
Date:   Mon, 23 Nov 2020 16:07:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <markpearson@lenovo.com>,
        <linux-iio@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        <linux-input@vger.kernel.org>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
Message-ID: <20201123160729.000038dd@Huawei.com>
In-Reply-To: <aeb7bc51-0b27-198b-d3b5-50b18ad114e7@redhat.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
        <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
        <20201007083602.00006b7e@Huawei.com>
        <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
        <20201112062348.GF1003057@dtor-ws>
        <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
        <20201113065832.GD356503@dtor-ws>
        <6df00683-9508-3dd9-831e-9b343658287b@redhat.com>
        <20201120095943.000001a6@Huawei.com>
        <aeb7bc51-0b27-198b-d3b5-50b18ad114e7@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.69.69]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Nov 2020 13:16:20 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/20/20 10:59 AM, Jonathan Cameron wrote:
> > On Thu, 19 Nov 2020 16:39:07 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:  
> 
> >>>>>>>> On 2020-10-03 10:02 a.m., Hans de Goede wrote:    
> >>>>>>>>> Hi All,
> >>>>>>>>>
> >>>>>>>>> Modern laptops can have various sensors which are kinda
> >>>>>>>>> like proximity sensors, but not really (they are more
> >>>>>>>>> specific in which part of the laptop the user is
> >>>>>>>>> proximate to).
> >>>>>>>>>
> >>>>>>>>> Specifically modern Thinkpad's have 2 readings which we
> >>>>>>>>> want to export to userspace, and I'm wondering if we
> >>>>>>>>> could use the IIO framework for this since these readings
> >>>>>>>>> are in essence sensor readings:
> >>>>>>>>>
> >>>>>>>>> 1. These laptops have a sensor in the palm-rests to
> >>>>>>>>> check if a user is physically proximate to the device's
> >>>>>>>>> palm-rests. This info will be used by userspace for WWAN
> >>>>>>>>> functionality to control the transmission level safely.
> >>>>>>>>>
> >>>>>>>>> A patch adding a thinkpad_acpi specific sysfs API for this
> >>>>>>>>> is currently pending:
> >>>>>>>>> https://patchwork.kernel.org/patch/11722127/
> >>>>>>>>>
> >>>>>>>>> But I'm wondering if it would not be better to use
> >>>>>>>>> IIO to export this info.    
> 
> <snip>
> 
> >>> On newer ARM we use "label" attribute in DTS:
> >>>
> >>> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> >>>
> >>>         ap_sar_sensor: proximity@28 {
> >>>                 compatible = "semtech,sx9310";
> >>>                 reg = <0x28>;
> >>>                 #io-channel-cells = <1>;
> >>>                 pinctrl-names = "default";
> >>>                 pinctrl-0 = <&p_sensor_int_l>;
> >>>
> >>>                 interrupt-parent = <&tlmm>;
> >>>                 interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> >>>
> >>>                 vdd-supply = <&pp3300_a>;
> >>>                 svdd-supply = <&pp1800_prox>;
> >>>
> >>>                 status = "disabled";
> >>>                 label = "proximity-wifi";
> >>>         };    
> >>
> >> Hmm, interesting. I did not know iio-devices could
> >> have a label sysfs attribute (nor that that could be
> >> set through device-tree). I was thinking about adding
> >> an in_proximity_location sysfs attribute. But using
> >> labels (and standardizing a set of label names) will
> >> work nicely too.  
> > 
> > It's fairly new.   Note we also have per channel labels
> > though they are 'very new'.  Might be handy if the sensors
> > appear as a single device despite being spread over the
> > laptop.  
> 
> Interesting, the thinkpad_acpi stuff currently has 2
> proximity(ish) sensors:
> 
> 1. Laptop is close to (on) someones lap
> 2. Someone's arms are resting on or close to the palmrest
> 
> Ideally we would indeed register 1 iio-dev with separate
> channels for this, rather then having to register 2
> (and the future maybe even more) iio-devs for this.
> 
> Can you give a pointer to docs / examples of using a
> label per channel ?

Docs if done with DT binding are at:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=7f79711533a96b02e1e24e2e36a29b08734e36e2
ABI Docs
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=3079188f821cfbdbb0b12f668335931a87eb14c6
An example using it directly rather than via DT (it's not really
DT related though in some cases the label may come from there)
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=1f4877218f7e2c2b914aeb69a8a0f47d59c74717

Those will probably be in Linux-next later this week.

Jonathan

> 
> >> Is there a know set of labels which ChromeOS is currently
> >> using? If we are going to use labels for this it would
> >> be good IMHO to define a set of standard labels for
> >> this in say Documentation/ABI/testing/sysfs-bus-iio-labels.  
> > 
> > If you do want to do this, please just put it under sysfs-bus-iio
> > doc.  I want this to be in the top level doc.  
> 
> Ok, ack.
> 
> Dmitry, can you perhaps dig up a full-list of labels
> which ChromeOS is currently using to identify
> proximity sensors for e.g. SAR related use?
> 
> Regards,
> 
> Hans
> 

