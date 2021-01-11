Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223E12F0CFF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 07:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbhAKGph (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 01:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbhAKGpg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 01:45:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213EC061794
        for <linux-iio@vger.kernel.org>; Sun, 10 Jan 2021 22:44:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so8986096plk.5
        for <linux-iio@vger.kernel.org>; Sun, 10 Jan 2021 22:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYIUlaTfC+qHfMej4twucGScSCQDmWbCEShoQb2dW8E=;
        b=SE8xprRJJp7ffnAN2XwtmMwNkjg0oTQfgcxyaAWnVaZUZrU4GG3WjpwwCx4rwly22e
         zrkIkta05MipEf8DDLMk+Xz+8omYJs4uGUhm/LlRVuVEkiVgD6ZgEtqgEn9ko1YoST91
         jVhCYSKUG06h1gjlBICdBBnYutTmpm3h5xuSM6jRr15t39I61POVg5fXrOTiry+1DIjX
         tMpgMZe3F5C2SIReJUnbsc4841SkFc+ub51ku13h1iCQcNzeshIBpXRq0rFbkRTJ8i+J
         wbw6hUqa7rviY13EmlN7qiDw1YFV7ZrPS9Wvfe0pIVKM26piJhCPoSgunjl2XtU06I8f
         OPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYIUlaTfC+qHfMej4twucGScSCQDmWbCEShoQb2dW8E=;
        b=loNWIOu9TUH8bU9YvBTTlWHu7O85cbaDl7vO/gVZvxGBmetBp0/5xf4GiTTgZ/5TxL
         QtYEWpoSxZYVnwBJihCCyO+CSamtrEfImF53GI5/KFSB+yPCll7FKij18fclOmHJnzaX
         7BZVb1rMVpcI0DWMmoC8r09QkTnrmArbXJjBnojUdUrKKul/1E19MG9uEruuccXBVVmN
         oMcYaVWkAFHxtrmqfFVYkhsXd6UfT59R2LSVdTqYsyKZjL0CV3Yevh/ITzEwjtc3Vbhm
         2Zz/I64LJ7oFtqkcArtsiArXAwagGEq6Dd9Ir9x9T1ohXuwSxBQ7wHIdCZcxIErEER2z
         xmXg==
X-Gm-Message-State: AOAM53344ImZJLHMLJo9S7fVsSVM9YmKGTwWgzmKbweHr/hZdBtNrCHU
        0pszMkIhZDvmgz48QOpP4glFlO62STZo8ELpI5nTTA==
X-Google-Smtp-Source: ABdhPJwbvxRmFXwN7HNR0Bbi52W2c2CAV0qBXCm39LOpqHYzcXv/9mi+DdpK0xzFmeZvCeZQrQ+DPEau+jP1ZyesYTg=
X-Received: by 2002:a17:902:eb03:b029:db:c0d6:5845 with SMTP id
 l3-20020a170902eb03b02900dbc0d65845mr18211576plb.76.1610347495820; Sun, 10
 Jan 2021 22:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20210106161233.GA44413@e120937-lin> <20210106212353.951807-1-jbhayana@google.com>
 <20210109190133.61051fab@archlinux>
In-Reply-To: <20210109190133.61051fab@archlinux>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Sun, 10 Jan 2021 22:44:44 -0800
Message-ID: <CA+=V6c3f5Z4_JOr+KzvxpL9nOcPrNAZYmG_VpUF+QAW4=cfy=Q@mail.gmail.com>
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

In section 4.7.2.5.1 of the specification, the following exponent is
the scale value

uint32 axis_attributes_high
Bits[15:11] Exponent: The power-of-10 multiplier in two=E2=80=99s-complemen=
t
format that is applied to the sensor unit
specified by the SensorType field.

and the resolution is

uint32 axis_resolution
Bits[31:27] Exponent: The power-of-10 multiplier in two=E2=80=99s-complemen=
t format
that is applied to the Res field. Bits[26:0] Res: The resolution of
the sensor axis.

From code in scmi_protocol.h
/**
 * scmi_sensor_axis_info  - describes one sensor axes
 * @id: The axes ID.
 * @type: Axes type. Chosen amongst one of @enum scmi_sensor_class.
 * @scale: Power-of-10 multiplier applied to the axis unit.
 * @name: NULL-terminated string representing axes name as advertised by
 *  SCMI platform.
 * @extended_attrs: Flag to indicate the presence of additional extended
 *    attributes for this axes.
 * @resolution: Extended attribute representing the resolution of the axes.
 * Set to 0 if not reported by this axes.
 * @exponent: Extended attribute representing the power-of-10 multiplier th=
at
 *      is applied to the resolution field. Set to 0 if not reported by
 *      this axes.
 * @attrs: Extended attributes representing minimum and maximum values
 *   measurable by this axes. Set to 0 if not reported by this sensor.
 */

struct scmi_sensor_axis_info {
unsigned int id;
unsigned int type;
int scale; //This is the scale used for min/max range
char name[SCMI_MAX_STR_SIZE];
bool extended_attrs;
unsigned int resolution;
int exponent; // This is the scale used in resolution
struct scmi_range_attrs attrs;
};

The scale above  is the Power-of-10 multiplier which is applied to the min =
range
and the max range value
but the resolution is equal to resolution and multiplied by
Power-of-10 multiplier
of exponent in the above struct.
So as can be seen above the value of the power of 10 multiplier used
for min/max range
can be different than the value of the power of 10 multiplier used for
the resolution.
Hence, if I have to use IIO_AVAIL_RANGE to specify min/max range and as wel=
l
as resolution, then I have to use the float format with the scale applied.

If there is another way which you know of and prefer, please let me know.

Thanks,
Jyoti




Thanks,
Jyoti

On Sat, Jan 9, 2021 at 11:01 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  6 Jan 2021 21:23:53 +0000
> Jyoti Bhayana <jbhayana@google.com> wrote:
>
> > Hi Jonathan,
> >
> > Instead of adding IIO_VAL_INT_H32_L32, I am thinking of adding IIO_VAL_=
FRACTIONAL_LONG
> > or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min/max range c=
an be different
> > than the one used in resolution according to specification.
>
> That's somewhat 'odd'.  Given min/max are inherently values the sensor is=
 supposed to
> be able to return why give them different resolutions?  Can you point me =
at a specific
> section of the spec?  The axis_min_range_low etc fields don't seem to hav=
e units specified
> but I assumed they were in sensor units and so same scale factors?
>
> >
> > I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED using IIO_A=
VAIL_RANGE
> > and this new IIO_VAL_FRACTIONAL_64 for min range,max range and resoluti=
on.
> > Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_FRACTIONAL_64=
 will use 4 values
> > val_high,val_low,and val2_high and val2_low.
>
> I'm not keen on the changing that internal kernel interface unless we abs=
olutely
> have to.  read_avail() is called from consumer drivers and they won't kno=
w anything
> about this new variant.
>
> >
> > Let me know if that is an acceptable solution.
>
> Hmm. It isn't a standard use of the ABI given the value in the buffer is =
(I assume)
> raw (needs scale applied).  However, it isn't excluded by the ABI docs.  =
Whether
> a standard userspace is going to expect it is not clear to me.
>
> I don't want to end up in a position where we end up with available being=
 generally
> added for processed when what most people care about is what the value ra=
nge they
> might get from a polled read is (rather than via a buffer).
>
> So I'm not that keen on this solution but if we can find a way to avoid i=
t.
>
> Jonathan
>
>
> >
> >
> > Thanks,
> > Jyoti
> >
>
