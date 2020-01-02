Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9096D12E1C7
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 03:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgABCsK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jan 2020 21:48:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgABCsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2020 21:48:09 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1imqVJ-00089z-Qe
        for linux-iio@vger.kernel.org; Thu, 02 Jan 2020 02:46:29 +0000
Received: by mail-wr1-f71.google.com with SMTP id v17so19426755wrm.17
        for <linux-iio@vger.kernel.org>; Wed, 01 Jan 2020 18:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz7z4GGlB5HAuo/J4rqK/C+YsZQ3SQ99xPr8rkpIjP0=;
        b=Nt3NXbFzVQTjVWa0npPweLuzJfm6OCxY2iVnOssaAJfJjVPzkdUF53CgiOTqMUtuWu
         toO/ZxBAY3+lxRhCw7SEZRhNRXbAfJO0OlG4nt7mS1HYZOZ2jaOaMCy6Fsmin5k7MEDY
         EJ5yDsl8rCVKJleGcr6TrXhZw3bDaGvoo5SMY4HNBhNmXKbezObnEcAtxUR/lYuHBGuo
         XSe0H6t5K+Hhh5V2t+/nla/GIW3+jTHKLS7QpjSOnvP2kpBKM1+TndBIn0q4m1Lr9HY2
         Ruo4LifRk3kdaeeKj2Oi4sm2QF+LrhmsMfjm/CWEMa5zKbGVziu5mSJRaan01BHAXQo7
         EAlw==
X-Gm-Message-State: APjAAAVPTSttuPtVEVJPB9e0pjqs1/AbDWpDgibmiuKrl87liaquHM+x
        hQDycAg98FVIQWMQepGTfyWCJNC5RIG4mAKXJa+jZ/luPytnHy/+v6siLsU+Vj5uUAP4uBAZSOi
        9OOrgJhx6KEjzd8IZk8KIvOJl00OKSeWU2Eq/g4cUmyThI2TdWeiZ3Q==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr11840845wmg.39.1577933189419;
        Wed, 01 Jan 2020 18:46:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYMmP86gYe2T8sIVWmRDeE/HN6gm6Zn8zPt6J+HOGZREvf5LSQ4vTpsFrXHImr/qAsm5OCHVtzEhGTLz1kHhU=
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr11840821wmg.39.1577933189010;
 Wed, 01 Jan 2020 18:46:29 -0800 (PST)
MIME-Version: 1.0
References: <CAFv23QmiDdhe+xJw2y7CXiWq4-GK1S-1bcKxEpNhNJu3ZtzA_w@mail.gmail.com>
 <9baeb165eddb4872fb701ff81f11692b7e153bf6.camel@hadess.net>
 <CAFv23Qmj_ZqKs9_tw1Grzzj5unFBLfK0Scy396vcHCEB+fdLOA@mail.gmail.com> <7830ad25a5cb7640e1da55c4278ce73c1ff3e0ad.camel@linux.intel.com>
In-Reply-To: <7830ad25a5cb7640e1da55c4278ce73c1ff3e0ad.camel@linux.intel.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 2 Jan 2020 10:46:17 +0800
Message-ID: <CAFv23Q=aOq1YCQnW7r_eSRn1COfpvQkfjtK2+a3zU0ggxnuYew@mail.gmail.com>
Subject: Re: Display got wrong rotation after hid_sensor_accel_3d is loaded
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000360dbc059b1f3346"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--000000000000360dbc059b1f3346
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this machine will be sold with Windows, but currently we didn't
hear any issues from Windows side.
Here is the rdesc I found under /sys/kernel/debug/hid

BTW, we're trying to push BIOS to provide some useful info about the
orientation of the sensor, so that we don't have to list those
machines in the driver.

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> =E6=96=BC
2019=E5=B9=B412=E6=9C=8831=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:=
18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Kao,
>
> Is this device sold with Windows?
> Can you send full report descriptor (You can get from
> /sys/kernel/debug/hid)?
>
> Thanks,
> Srinivas
>
> On Fri, 2019-12-27 at 10:30 +0800, AceLan Kao wrote:
> > Hi Bastien,
> >
> > Thanks for your suggestion.
> > I just tried to add the following line into
> > /lib/udev/hwdb.d/60-sensor.hwdb and got the correct screen rotation.
> > But the cursor is still un-rotated, the cursor is drawn upside down,
> > and its coordinates are inverted.
> >
> > #########################################
> > # STMicro
> > #########################################
> > sensor:modalias:platform:platform:HID-SENSOR-200073
> >  ACCEL_MOUNT_MATRIX=3D-1, 0, 0; 0, -1, 0; 0, 0, 1
> >
> > It looks like we should introduce a quirk into hid_sensor_accel_3d
> > driver.
> > There are 3 different scale variables in hid_sensor_accel_3d, but I
> > don't see any of them would work the way I want.
> > Do you mean to introduce new scale variables?
> >
> >    drivers/iio/accel/hid-sensor-accel-3d.c:34:     int
> > scale_pre_decml;
> >    drivers/iio/accel/hid-sensor-accel-3d.c:35:     int
> > scale_post_decml;
> >    drivers/iio/accel/hid-sensor-accel-3d.c:36:     int
> > scale_precision;
> >
> > Bastien Nocera <hadess@hadess.net> =E6=96=BC 2019=E5=B9=B412=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:03=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Thu, 2019-12-26 at 17:22 +0800, AceLan Kao wrote:
> > > > Hi all,
> > > >
> > > > I'm working on a new platform which comes with an accelerator
> > > > meter.
> > > > It's a STMicroelectronics LSM6DS3US accelerator meter, it doesn't
> > > > use
> > > > st_sensors driver, but hid_sensor_accel_3d.
> > > > After hid_sensor_accel_3d is loaded, the display becomes upside
> > > > down,
> > > > so I tried to add some code to make it become normal.(ACCEL_X
> > > > should
> > > > have the same modification)
> > > >
> > > > I don't know how to fix this in a correct way, please give me
> > > > some
> > > > hints.
> > >
> > > This needs to be done as a quirk, either by applying a quirk for
> > > the
> > > HID descriptors (which should have a definition of the scale, which
> > > would be negative for this device), or in user-space in systemd's
> > > hwdb
> > > database, which your user-space consumers need to take care of:
> > >
> https://github.com/systemd/systemd/blob/master/hwdb.d/60-sensor.hwdb
> > >
> > > Cheers
> > >
>

--000000000000360dbc059b1f3346
Content-Type: application/x-compressed-tar; name="hid.tgz"
Content-Disposition: attachment; filename="hid.tgz"
Content-Transfer-Encoding: base64
Content-ID: <f_k4w4i3cy0>
X-Attachment-Id: f_k4w4i3cy0

H4sIAONXDV4AA+1dXXOcSJbVs38Fj+4HqfMTKD/0hMdtz3Zsd09H296dDsc+1AeyFeuWHFJ5djy/
foGqLKgiyeJCQkHVIRQSOpkJ3JuXmzc5yeXT3er7q543lm6R1vnfdDv8m+9zGTIptIxkWo+nu9FV
oPu+sGz7+rSePwbB1ePDw9pV71j5RLdPaf8zxuMXTMXxCy7Yy5u0O/TN4yp5Wno6R9bBoVI1/a+U
DNWu/zUXaf/LDAqYp/M7twvvf6YDxgM2C5gI5jzbj3cIzxEWZHVmAc8Rkf6WAdcZLvKaUf57pjM8
5tlxsn2d7/Ngd3zJ8t88a5sWpW2j27xtnNcXef0wr7NBuEHS/WXA5hm+q7Zk2U9WtMovVZcuPs4Q
sRFH7F1qiqso/y22J412JxLbk0a5IEJvpdam9FBMuRVte/wwkLcZklbjLNApmARhum9kl3k1FQZh
etmqJKDI2t7eZjtpacyynY2iNqXLzdGWQRjmp2OZCGn9rAnLT73/7+YCNsff6UeH26Nl+2orXSFv
bEpzkTddf9i5ZS1FJQ2scp3nrbQudSjfnmWxO+/M7IfZdaYXnDWcZ0VLXahxI8j2OHnN9FALowqW
KyGrs7PPTafLLWI/Tnr8xfb6s8pqa/CH+EYQuZVxscNzs0xbxeXLELbLiIojx+H27MXF78w1KTVZ
7Jlrpqiy0c73VFocateE5QdZ5g3zs+u41Gti24+LXd+F+b7c3kHPngXBT7/+9v7dc/7dh3znf1Ik
CN7cJZ9Xz9l3+T9B8Nunb093y/nn539L7pPHu+WPydP/rh++3Pz2cHe/Th5NtZdfvnxOq63vHu4P
a/7y8PUpMfXeP80/Js+l+TcI/vp1vX64z0YebsGEBZNb7OeHj9mFBb/c3d/9+fXP4pJ3BfN/5QXc
FPyefHl4XAdv7/6dVMBXD1/v18WFbdG/394+Jevi0G8+zz8+PQ/+a/54N198ToKXi6eHz1/XSfBd
SXe8V92JQncHlf9RV/BHjcauuYhqlVYUldUWW9Um7GqL69T2e/I5Ffef+2oTvaqN16rtvz8lyee+
NXRoblsNCUVSkRxKRa8e7p++/pk83vzHw+Pdvx/u1/PPp1STFI3UtHFnscudba/u+Y93H+/W6XU8
Pt28ubv/aFdZqdK7h6/LT7/NV7X3Yqluqrzbu1Vyv0xspe/uvrz9v7v18lOPbqzmfmzpxvzqjNfp
bD1frn/6kaoVbdPKoRt334MkrYjetVLj1ZvbiVQVP1FtVZSYZukMcHdN93fr4PW/vjzcJ6nerkUZ
f/72p+Dnu/sknTq9CF6l5Xd/JiWXs2ecIaUfakcLaz/IofuhbhCt7YcojFp0Q6hO2wv1I5K1G1RX
LZfqMqZDqpJDraVuo+ZyuwNFq1pFv02WD/erp+5aVjRXrD1qeetp88tr7WxPqWlS5KBDkqLDroqu
Tmfo4/tJzZii3LCZr9iEZdIVlpXVfXvLeK7Ag1grKrS8qwLkbJHG943QI3ZLlckPKRTf3DmqhztH
ADlbBHeOuXPCjneO5cZRJ0DOo0M79eeb1y/fvf/99fPZdx+2u0f7tFt8vFXOr1//XCSP1H4YcS/U
hHItHw150PcmYn737Uty/lpu9ojD2DpnHo1dFDOh3MGw1MEsNRAgQIAAAQIECBAgQIAAAQIECJAz
RM7jcXLpgVaXB8q6+TO228YkgTwBch696oUkiEh9Kix9yqXa69W8jgACBAgQIECAAAHiGTmPGLYU
PHaJYjl3h7FtX3z4Mfnn3TLJX1L6+PUxL26yTuOn+y9f1788rMjLNLilQ0bTVV46Srg7aveynvee
sr9/xpiOavCY3Hlj6DvvL7k9Ky3TD66vr38I/jP5dvNzcrv+6/q+VCiKwt/vPn46KJVF6S93q9Xn
JCs+fHtrU8e8pnjzj8MKfxxU+OOwQv7e5UGlvzyre0GzUtH6XuKm1ttv98ubjfKe2V5QdNbavbBX
rWVXgaPGH84zZa8FNbmU3CqqFZ1dfWse6RRFfwEIsCEoquaGIhRNv0gV1v7Xx2zku0+ent5/mXz5
qXMujWnb5v968yJmcfSCvXyVT8XkcPm/0klcyIv8b1pHWf4vJZH/a5CN6UCwvWxfsUkdtcGTUhaw
DJkHPDQpwDY5nuReiqJtGqN5oFieiivd4WZHmHRIm+xd8/xEonSoyH4oZg7FzKGYMDvS7Cizo81O
WDndrNGVS3M6aU4nK1fODw4V2g+lzaG0OZQ2V67NlWtz5VpXLliVsq2ZPF+bnyjvjs3pdF5hsVNX
0qpVvFXINn1YVCqK9op4WCoK94vKrfR+UflcfK9IlIr4vM3F80UrkUXtZSiVHS0VZ5NV7SDV2pEj
mztlAPOOy9Yi9k9XY5PcnI6b03FzOm5Ox83puD48izZ57g5kj3c2nxypIGb7FUReYVaqsLBVCIsK
ae8wXWRJu73dk/TgdCr3Zjw0nRgW3cdtV7jc+EABHwgfCB8IH3jBPlDCB8IHwgcSfeAtfOAofaDu
32EqOEw4TDhMBI1n4TDb+UANHwgfeNE+MO2d1A/AB47TB2b3zn7vxPu9E1V7Z15qrro1192ar3Kf
TDStovmyU/OWI0KIEQEjwmWPCBFGhBGPCBHdJy9KzeNuzWfdmk9xRIgwImBEuOgRId3BiDDaEWH7
nITkk22PmmNW+dJhpXLWp6pp5Zb+Noa/hb+9aH+L59IT8Leb7u7huXSLT12+Te6fHh5v/r7+lDy+
+vq0fvjz8J3LbQ0mHMlgTJ2YMQvGLZiwYNKCKQumLVjd15QOv+xWfLLK+5uTLx8f59+afiaTonex
r/fQondu0Tu36J1b9M4teucWvfO6pEq1Oj7MWtQ9i7hDx9VvatbruPLyrxFS61svQsrDNzadUnLa
l5uqn8ZsJWnd2819SqpoX75TZEmFRVIxc2B06Q9e87U6khqt1H08tuUn0rppZeHAumqFYio1SuGK
9nm+0Mtdobp8iKT9t3EZ7b6ofG2xnazk70/tve7e4cOLDR3eJpARCGQQyFQwBDKFIhHIDC4pAhmb
VhDIWJSCQAaBzPHPwiKQiex34PWh7hHgBP0FON51j8AHgQ9JUgQ+CHwQ+DSUtct3DtrLSvR2sR9Z
TxbkiWZm3OAL5gjy8LQKT6sQtA0tKYI2m1YQtFmUgqANT6vyQEYjkEEgU8EQyBSKRCAzuKQIZGxa
QSBjUcpJAhml675ReC24ilQsw8KEKyGNqVHHhHi4gU4S8ihdF96NRSuKdgd5eaKldN2AOBatRIKk
lZmfcWVFDY/tLBVNVslo3qL6pZ92wi5PIqykBQycEn+OcOIjw2ZObzPxCTHxwcSngmHiUygSE5/B
JcXEx6YVTHwsSjnRxCeq0YCPYNYaA0xi4lP3FcKxaOU0E586HzIWrWDig4nP5U18Ikx8MPGpYJj4
FIrExGdwSTHxsWkFEx+LUka2dKVVMDuxCU79CuRrLmrF5qL7WHqamcuiLpLrX1xa7/qZkpxuqZKm
LFWKEbgicK1gCFwLRSJwHVxSBK42rSBwtShlZIEr1lwPv+b6zeuX797//jo9zIftrq9gRhZXsNGP
rOonVpZBVVkGVSVq9Fh718jOFjNY8IGgb4iApGKfbHbcPqVF79Kid3kC+6zc4Q5FUeKZ6o18oChb
dKwtitIWRWmLgWqLgWqLgdauW+wxOq68g+tQMj2UsgwZkpGHRy8MFY15pMdHVlHr4uNeRQ37Dnos
Dlyy+MRYRxXXRB+H3n6r4hlttkWPtYQl3JYsAjYZrB97FDUzHWr0T39qKyzhg9yFT8CmifVkpYfB
39ZKdUh7StHiYbsldpOWwB/YMawfy6jAZkAVNP/VYrWUtA6p1RAeGLB+sX5urcokwUyjeUxciehl
cZ7kcz/iUnkQYmzOvZA+ktc99u5X2ojqN+nEj91vVh9zAAPWLzaw34yI0Sr38XyMt6CPfHgS0XRt
viFUBAgVECoWDIRKFQOhUlUACBUQKnRRQagMhoFQATYmDIQKsPFjIFSA2TEQKsCA9YKBUKGIC0IF
hAowYCBU+vQkZEJFglABoWLBQKhUMRAqVQWAUAGhQhcVhMpgGAgVYGPCQKgAGz8GQgWYHQOhAgxY
LxgIFYq4IFRAqAADBkLluLgHme9OQbQoEC0gWiwYiJYqBqKlqgAQLSBa6KKCaBkMA9ECbEwYiBZg
48dAtACzYyBagAHrBQPRQhEXRAuIFmDAQLT06UnIhIoGoQJCxYKBUKliIFSqCgChAkKFLioIlcEw
ECrAxoSBUAE2fgyECjA7BkIFGLBeMBAqFHFBqIBQAQbsQggVtXtaOG5CJQShAkLFgoFQqWIgVKoK
AKECQoUuKgiVwTAQKsDGhIFQATZ+DIQKMDsGQgUYsF4wECoUcUGogFABBuxiCBVPM8ieCZUIhAoI
FQsGQqWKgVCpKgCECggVuqggVAbDQKgAGxMGQgXY+DEQKsDsGAgVYMB6wUCoUMQFoQJCBRiwSyFU
Fp6GiZ4JlRiECggVCwZCpYqBUKkqAIQKCBW6qCBUBsNAqAAbEwZCBdj4MRAqwOwYCBVgwHrBQKhQ
xAWhAkIFGLALIVTG/Q2VZ6ZXYsaC6+vrH4K33+6XN5tjlQq5q1C4CqWrULkKtaswdBRylyjcJQp3
icJdonCXKNwhita3rsLEUShmrQsXbQuVQ06tnGYCA4OBwcBgYKM2MJecsD5YH9wbDGzMBqa0QwlK
O5SgtFMJK1fhEkYNo+7TqCNXYewqdF0QjBpGPdZQwCGnWjgUD9OEaQ4fpV6daPt0t/qeMf7mRczi
6AV7+UrcMMbEzeMqeVp6Okd6QBYqlf9Nt/2/QqlIiCsuQyaFllrzK8alEtFVwDyd37l9fVrPH4Pg
6vHhYe2qd6x8olvqPgQL2CxIfdecB6l7i3W2v8MTg2+RecDDIHVXPK8mdLYfpb/jYKbNQURWTbEM
zHa42RHZziI/2jI/FMsrF4eK7Idi5lDMHIoJsyPNjjI72uyEldPNGl25NKeT5nSycuX84FCh/VDa
HEqbQ2lz5dpcuTZXrnXlgpU5CwtEFNzeFj9R3h2b0+m8wmKnrqRVq3irEL6pEJWKor2i1ACKonC/
qNxK7xeVz8X3ikSpiM/bXDxftBJZ1F5G6sB5Lk5me+an6ZHNnTKAecdlaxH7p6uxSW5Ox83puDkd
N6fj5nRcH54lHYjTa6jKHu9sPjlSIR1z9yqIvMKsVGFhqxAWFdLeSStsu1tv+2In6cHpVO7NMq+1
6cSw6D5uu8LlxgeKwgdGIXwgfODF+UAdZn6A5gMX8IED+UAdZQop90683zuRrXeK5nG35rNOzcNc
/KOmtSw3n3drzkbRfDu4yNLgIjG4YHC5vMFF0AeXOQaXoQYXSXfvJf+c3XFdmutuzXneXDeaHbRx
5qtRDCV+RiKFRz0YiS56JGrzqAfTnIEf9bSdaCjdrXnYrXnUrXncrXlldKA1562em2kMKBhQMKCA
Oxj3gNLYrRWDCKlJSG/SYrCYdxss5t0Gi3Lzebfmi27Nl92ar/qnk0IMixgWMSxiWBz3sNirD4zg
A+ED4QPb+sB5EKY3GiPGOXCh5+JC059nz4Lgp19/e//uOf/uQ77jK3szshKfKhu02Ne7Ldkut+id
W/TOLXrnFr1zi975CZLt9pT5uTYrkda3XoSkpmAipU2hZySySlqXardPSRUt+RI9P4wl9ZIWMwdG
l/79/d06eP2vLw/3SSrotdWR1GilJnFOTEubQ0+1bNXKwoF11QrFVOqyCam+szLb7gp6LiGhtU1Y
Wk5xYjJaenpkq6zk9Hqh1tIqbV3yyhpxGzq8TSAjKIHMLw/ru4f7v317fPgzWSeP8sdLC2cOvFN3
2/QR5hB6ZfrBjvce8BEE1fbAmYZCbeSdckB0RN6LDova6OZSgiP6faJ0XcL+a8FVpGIZFkZdCZZM
DdJ4RUzM6CuYaqObuo9rjEU3inZP1X71oI1u6nzLWHTT8ANpR3Pttxh7wjrdNEhheqAJq3fhM9q3
fxgxATY9Hu9HFx1kVtQ02PRod3QyhzExGbbP+PJEMscNw4rN5FPSJ58vl8vkc4IJqMMdnWgC2rhn
zm4SOo4n8c5eOOuJKF3m6U9GnTJjQtpCP5c1KaXeM2r31dA+Jhgebi/PE1O6fuq4jbHox+/klK6f
uuF2LPrxO0Gl64fMF/ngxnzPRclDsce5ufUTz9S5OadZwbF56qD66CC3ptqB7zD0VHN06nMJ36Ho
yebpzUbLzTxdYbXbdOnhC1kFN0piGKvjzm/+jdVx3bVyKXNtP6vjxkLhnWYdXZ/zxjGRvjSt1AUp
Y9GKr9k0TSsjXzzhb7ZNU8vI101I6Yscpqll5EsmZOiLP57GwmXFKNyxxpwUb2BVMLyBVSgSc8zB
JcUc06YVzDEtShnZHLP3t5LGNXnsXVxB692eZ4W9i0ucBE9guueDUtbEec0Epns+1EJdFzuB6Z4H
tUhBu4d8TffmI1eLJjLyfsJHVRcqjEUtMfFREj3WtKplOW61KOJcg9ODTataVtSB18fiHUWcbnBP
MeTJHhA1HE83D4hCPCDCA6IKhgdEhSLxgGhwSfGAyKYVPCCyKGUqD4iQoqfnFD0RAhkEMhUMgUyh
SAQyg0uKQMamFQQyFqUgkLn4QObN65fv3v/+Oj3Mh+2ur2BGFlew0Y+s6idWlkFVWQZVJWr0WHvX
WN85G2fwgaBviICkYp9sdtw+pUXv0qJ3eQL7rNzhDkVR4pnqjXygKFt0rC2K0hZFaYuBaouBaouB
1r6o3GN0XFkt4FCyFyJHMvLwaH/vkMpx9hwfWUWti497FTXsO+ixOHDJ4hNjXd9itUcfh95+q2Li
u7v0WEtYwm3JImCTwfqxR1Ez06FG//RVX8ISPshd+ARsmlhPVnoY/JlcD2Hvi/UssZu0BP7AjmH9
WEYFNgOqIC4ooS9YlNYhtRrCAwPWL9bPrVWZJJhpNKcu2POy6lXyuuWdvU5+ODmvjhfSR/K6x979
ShtR/Sad+LH7zepjDmDA+sUG9psRMVr1stCZt6CPfHgS0TRvgiFUBI1QafypINAqFG2BXOmBXGlu
q6BYaLc2iJZGqm77Oajzo1vaCDxp0uWIwKBefFEvx74eBgJm4thECZhjdgka5gyxidIwx0ZnkDGe
sKmSMUcMBJQMsHFgk6VkWkyQJk/MtJF56vRMK0966gf2wC4PmyxJQ/YqXOkO8XsPma+pFI5sQ+E0
/NgmaByqxkDl9EblNLVZ0Dn02xyUTiN1d/mo6rnSOnShz4DacQoNescvveP+Fi8onoljk6Z43LYJ
mucMsUnTPO7RGlSPJ2zaVI/TSED3ABsHNnG6hzxxOhPKhy73edA+LbzqqWkAYJeHTZz6IXoXrnQH
wXv4uAmV/lFIidYH6YOUaEiJZtfTSAgepERDSjSkRENKtHESN0iJdrbYROkapES7KGyiJA1SovWO
TZWaQUo0YCPHJkvIICXa+ZIvSIkGbOTYZCmXwVKijeA9Gw2iBUSLBQPRUsVAtFQVAKIFRAtdVBAt
g2EgWoCNCQPRAmz8GIgWYHYMRAswYL1gIFoo4oJoAdECDBiIlj49CZlQCUGogFCxYCBUqhgIlaoC
QKiAUKGLCkJlMAyECrAxYSBUgI0fA6ECzI6BUAEGrBcMhApFXBAqIFSAAQOh0qcnIRMqEQgVECoW
DIRKFQOhUlUACBUQKnRRQagMhoFQATYmDIQKsPFjIFSA2TEQKsCA9YKBUKGIC0IFhAowYCBU+vQk
jQmVnbQ+HpHdsrBuJnItuIpULEMV18m9q2F9Jk+UX7Imo+QzY5UxY8H19fUPwdtv98ubzbFKhdxV
KFyF0lWoXIXaVRg6CrlLFO4ShbtE4S5RuEsU7hBF61tXYeIoFLPWhYu2hcohp1ZOM4GBwcCOFiod
uQpjV6HrgsLhC2HxsPhGFu9QgtIOJSjtUILSjl7B7YDbYaS3w5EIwyWncnSZVo5xRSvHuKKVS06E
PLD4C7P4uavQKefSVbjCXYa77GR3GQwMBja0gV2Rtk93q+8Z429exCyOXrCXr8QNY0zdPK6SpyXt
ULVbekAWKpX/Tbf9vzydb4jwisuQSaGlDuUV41LJ8Cpgns7v3L4+reePQXD1+PCwdtU7Vj7RLb3p
BQvYLEg9zpwHqVOKdba/wxODb5F5wMMgdTI8ryZ0th+lv+Ngps1BRFZNsQzMdrjZEdnOIj/aMj8U
yysXh4rsh2LmUMwcigmzI82OMjva7ISV080aXbk0p5PmdLJy5fzgUKH9UNocSptDaXPl2ly5Nleu
deWClTkLC0QU3N4WP1HeHZvT6bzCYqeupFWreKsQvqkQlYqivaLUAIqicL+o3ErvF5XPxfeKRKmI
z9tcPF+0ElnUXsaKB+kIk4qT2Z75OXLklWlu7pQBzDsuW4vYP12NTXJzOm5Ox83puDkdN6fj+vAs
6fCZXkNVq/HO5pMjFdKRcq+CyCvMShUWtgphUSHtHUbvnaK56NZcdWuuOzVPA4JUOVtT19vKu14+
UHU6z2OaeK5y87Bb86hb83wYyoabTcOwaMJtTZabwUsUg5fC4IXB6yIHr4TqYRJPY988SDbe1emg
isqSUJnnvexwCFzsN8FAPOKBeOuuJdw13DXc9cncdRoMd2quujXXGGsw1pxm0hfvN4+Ikz5ac92+
+XagVHgoh4HyogdKlXtv6vME+Odh/POixVO10gUs+PHRudNDsIaVQ0rljg+4Ysq5OPlpWPrz7FkQ
/PTrb+/fPefffch3fGV2OteMRQcfip9QBimx3x+2BD3c0h/c0h/c0h/c0h/c0h+8fYIe77rvKYtU
7RuOWt+2Fr4sJPV1TtJLSfS3G62S1qXt6VNSRXuRk/6umeU1Ti1mDqyzkVNey6p5CS+mvYJHfyfN
qpWFA+uqFYqp1L2ZqPrO8GS5K9Sqw+vrTbwf8X09YsIbegomqw46vIragw4U7e6gJ/2x6qDD+6k9
6ID42mqLlDI2HXTIkuJfB81eXS100CJ5im2YpL+oLLS2SUuKe6Qk5nfwks1CK095cYg9S/T0fpJZ
aOUpPRRR2IjYs36iPeUpYxsx3COOX16SC2TLaqnChlpL611bl+GpRt6GY9VmRi8oM/qf7z5+Wr/8
c3GX+tN8/0CUs5/Xn3T+TtD+9GfxJ52t12r6TOfsbeSd8sz9iLwXPX9vo5tLmcXT75OJzuU3sYFE
bIDYALEBYgPEBgFiA8QGiA3Kmqh9zt9GE3VP+1vlJhzx8/82uql7+DsW3fjiBdropi6IGIlumvIF
m3hbYXXN+CPtC1lFg9UyWC2D1TJYLXOSWJq0QmDhKWn5FFbFLMgzBh8LAU6y+uVEix4E0d95WeXS
Ys2DF1k1cRmAp9Us5DUPXoQlfqzR12qWk6x5IH9iwNNqFvInIr2sU6IuyvK0muVUCzwkb9a55oPc
HB/kPtlEEBPwISaHFfvEB7mb3sj4IHcjJeOD3PggNz7IjQ9yA2uA9WOP+CA3MJ9YT1aKD3JPHuvH
MvBBbmAXj/Vza+GD3PggNz7IDex8sYH95mk+yD22BbFNWTRDtAga0dL4nQ3QLRRtgXQZ8q0XUC/d
1AUCppmq276vc340TBuBJ03GHBEYlIwvSubY610gZiaOTZSYOWaXoGfOEJsoPXNsdAZJ4wmbKklz
xEBA1QAbBzZZqqbFBGnyhE0bmadO27TypKd+kA/s8rDJkjdkr5L4pHAO5euTwtnpwt9jt9HRWeT3
pHzmuknIN4OXl/7IOax9ZrVJ5Glkpqaybp2tJq4KLbnlsSgwT1h/rxoemtjOmDSNA5dnzoGP8stO
F8+Nj/KbT5PjzL1rEVx6x0w13bsAHDs49kJgcOzg2IH1ioFjBzYVDBw7MHDsW6FPzbcCuzwMHDs4
dnDswIB1xcCxg2O/bI6dj+2b6Sfk3vnYvp0uQ+KI7O8LMnxk31AXihF9p88vxpxoHYoiMhOi7dx2
ROtQmn6Ieidz69kG1qGc/ToU1TAvv1mHos426fUoV6BccDLsUa49mVCS7HGuOrmQ5NnjXG+CpNrn
uMYESbWRVBtYW2yi60qQVPuisImuKEFS7d6xqa4lQVJtYCPHJruKBEm1z3flCJJqAxs5Ntk1I5Sk
2i2+o+zlC7TNVoU8M70SMxZcX1//ELz9dr+82RyrVMhdhcJVKF2FylWoXYWho5C7ROEuUbhLFO4S
hbtE4Q5RtL51FSaOQjFrXbhoWahWDvWplUN9auXQkFq5NKQcLbVytnSYiVaRq9Bp8bhXcK90u1dg
Q7ChkfpbmCZMs4lpLlzWt3Do9jQDekwc7a8ms326W33PGH/zImZx9IK9fCVuWPr/zeMqeVp6Okd6
QBYqlf9Nt/2/IhSpfV5xGTIptNRZPS6ViK4C5un8zi2dic0fg+Dq8eFh7ap3rHyiW+oeBQvYLEh9
85wHqfuOdba/wxODb5F5wMMgdcc8ryZ0th+lv+Ngps1BRFZNsQzMdrjZEdnOIj/aMj8UyysXh4rs
h2LmUMwcigmzI82OMjva7ISV080aXbk0p5PmdLJy5fzgUKH9UNocSptDaXPl2ly5NleudeWClTkL
C0QU3N4WP1HeHZvT6bzCYqeupFWreKsQvqkQlYqivaLUAIqicL+o3ErvF5XPxfeKRKmIz9tcPF+0
ElnUXkY6zPBcnMz2zE/TI5s7ZQDzjsvWIvZPV2OT3JyOm9NxczpuTsfN6bg+PEsaaKTXUJU93tl8
cqRCGlPsVRB5hVmpwsJWISwqpL3Dcjvc9ktY9AivOWkaGpCbhHkTog0UzaNuzeNuzWd0eTmtyXIz
WAgMFhgsLnuwCDFYYLCgN4noTWJ6kxYDwXyosUNi7MDYcdljR4uJxhxjx7BjR6l34v3eiWy9cziO
tG5emYDQmrfzyQo+GT4ZPhk+GT55ND5ZwyfDJ8MnE33yAj55xD550c0nL7r55EVnnxzCJ8Mnwyfj
ufe4ffKmu/MKZUn9PL+N4APhA+ED4QMv2AfG8IHwgfCB8IHT8IGbvvDoA9OfZ8+C4Kdff3v/7jn/
7kO+4ytz57lmniy/nTvOjJ9iX++2BIncondu0Tu36J1b9M4teuftEyS21nFPWTxrM0ZofetFSGp6
DNIr7fRsEVZJ69Ig9ilpw/zD7XNbWtJiaDFzYJ2zfVodSY1WapIaxLSUBvQ0mFatLBxYV61QTKUu
04PqO2Om7a6g53kgJ+euSfVAzBVIz15pFZecWMyXuJUUt75TI1rF9ZRhj/ytBpKsLRLs2WT1lPOS
KCv1Mzb0lHFWYT0lnCWmL6Z+p8ZLDi+t6sauvm9a8rdo/MRkipyizZe8upkxbyZcAhMuTLgqGCZc
hSIx4RpcUky4bFrBhMuiFEy4MOEqxD3VhMuXuBOZc/kSVxMj81NNu3zJS51mTnzmJWJiRmFPMy9y
tmhfMy/qzNpPiHa6maZo5q42M02JmWabj8p1nx1hBto2aMfMFDNTzEwxMz2Hmem14CpSsQwLE658
+tnUII1FRKplXBPYsWiFOPHreZ47Fq0Q50uepsMnC6cbTh824bRCOI1wGuE0wmmE0winfWgF4TTC
aYTTCKeDiwynNcLpNuG0tZ8QTg8STnfXPcJphNMkSRFOI5webTht9YcXH0770Mr5hdM+tIJwuj6c
DhFO47WCCobXCgpFIjweXFKExzatIDy2KGVk4XHt4H54+XQnd6KQ91RhjGjo7jZhTIQwBmFMBUMY
UygSYczgkiKMsWkFYYxFKQhjEMakYUyMMAZhTAVDGFMoEmHM4JIijLFpBWGMRSmTCWN09zUZCGSs
4r55/fLd+99fp4f5sN31FczI4go2+pFV/cTKMqgqy6CqRI0ea+8a2dliBgs+EPQNEZBU7JPNjtun
tOhdWvQuT2CflTvcoShKPFO9kQ8UZYuOtUVR2qIobTFQbTFQbTFQfYLouJIox6FkeihlGTIkIw+P
XrJX0hZd0OMjq6h18XGvooZ9Bz0WBy5ZfGKso4proo9Db79V8Yw226LHWsISbksWAZsM1o89ipqZ
DjX6py+1E5bwQe7CJ2DTxHqy0sPgb2ulOuw9T50ldpOWwB/YMawfy6jAZkAVxJRv9JR+0jqkVkN4
YMD6xfq5tSqTBDON5vEpEvdLTk6n6GPyw0NibO4neaTkdY+9+5U2ovpNOvFj95vVxxzAgPWLDew3
I2K0yn08H+Mt6CMvn7Jp+lqSIVQECBUQKhYMhEoVA6FSVQAIFRAqdFFBqAyGgVABNiYMhAqw8WMg
VIDZMRAqwID1goFQoYgLQgWECjBgF0OoeIrNeyZUJAgVECoWDIRKFQOhUlUACBUQKnRRQagMhoFQ
ATYmDIQKsPFjIFSA2TEQKsCA9YKBUKGIC0IFhAowYBdDqHR4PtbD5ympRIsC0QKixYKBaKliIFqq
CgDRAqKFLiqIlsEwEC3AxoSBaAE2fgxECzA7BqIFGLBeMBAtFHFBtIBoAQYMRMtxcUdAtGgQLSBa
LBiIlioGoqWqABAtIFroooJoGQwD0QJsTBiIFmDjx0C0ALNjIFqAAesFA9FCERdEC4gWYMBAtBwX
94BosX7bvmeiJQTRAqLFgoFoqWIgWqoKANECooUuKoiWwTAQLcDGhIFoATZ+DEQLMDsGogUYsF4w
EC0UcUG0gGgBBgxES5+ehEyoRCBUQKhYMBAqVQyESlUBIFRAqNBFBaEyGAZCBdiYMBAqwMaPgVAB
ZsdAqAAD1gsGQoUiLggVECrAgIFQ6dOTkAmVGIQKCBULBkKlioFQqSoAhAoIFbqoIFQGw0CoABsT
BkIF2PgxECrA7BgIFWDAesFAqFDEBaECQgUYMBAqfXqShoTKM9MrMWPB9fX1D8Hbb/fLm82xSoXc
VShchdJVqFyF2lUYOgq5SxTuEoW7ROEuUbhLFO4QRetbV2HiKBSz1oWLtoXKIadWLjmVo8u0ilyF
savQJady2i0sHhZ/dhY/x+2A22GCtwNME6YJ04RpwjRhmjDN0ZgmDAwGBgODgZ2VgV1hw4YNGzZs
2LBhw4YNGzZs2LBhw4YNGzZs2LBhw4YNGzZs2LBhw4ZtTNv/AyCgipwAUAUA
--000000000000360dbc059b1f3346--
