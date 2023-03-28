Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F876CC11E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Mar 2023 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjC1NiY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjC1NiU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 09:38:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E1AD3F
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 06:38:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so12243213wra.9
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680010696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ih/QFD4699GQTgOwf8rhf/a/1E2YoW0EVPI0rMy+M4=;
        b=oGJ9wHg0K7RZZeYOFGPHArHEmx1HvPOG1gzaWzzGBPCGQ3V3XS/eb+qnxBvhYpYjzb
         W9+2Ivs/BmHJxOK2eHKnv5PJMqHJB85cNOjD2S7IdNjDZWkipDMEQ0nBXSkEnxipnsfs
         UEXqIUdwIdqZM0dXJaxwYngqYQ1E4nDiKGXiJCG3R45tCUXY7pgrZz+k5GHBDp26R1EL
         R83icRpoM5/NB5gzXymFTNDF37k4LlvP6LdbBay2HlZHWqDCwfvdaoFHphGuwSzP1zYd
         P/L0MbkWxxIlz0slaVObOpfJYCAbho82s03dgIRBIcAlxkbHNpcRj5sj9WpVaMi2bllU
         o9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ih/QFD4699GQTgOwf8rhf/a/1E2YoW0EVPI0rMy+M4=;
        b=vtyBcFKL2EipLRjInHv9iGU5vIcmbuDX/yTDO/Cbr+mKfhnQUASY2pY7oWs9ORbIS2
         dtPRBzHakeGNP4myXXjq/Ap6qSywN13f1/8Fmo9N7mehnLOJNeYZWcGjh9uG7OEAlv9k
         eKARMs1Ti+UtQBlH4CFKCU/Lvbt7asv01V6Qlnt8pKFFc5v9CazwZNt0wmUgSCzHzHFc
         k4rEhTJH0VjOzsU0CmiY1YJ75M39yNi0PP5DjvrnXm/k1uSUgeim6BP4xsGPCKwRQV5k
         DMBPhCUEw1cCpmkQ3KFFhkgPjVprtD179iYm32bc/k6sBgZTr9uWfkB2Lm2j2rqqamsO
         ZEhw==
X-Gm-Message-State: AAQBX9cSYIHLGpWqHkQpmh/iplR33bEntewCiZEyiSP3d7PmUvJ25eXY
        ff9keH8LMHmdZAzV0oSbHpkiHG87sE75RVgUSAyKcQ==
X-Google-Smtp-Source: AKy350aH9TyXEhCcLK6qS9ZANGOn8WPoVK6WHzfEv9Z7Msh2J+Zbtswi//6EdgBdPJVi0LwekHbKSfPvM+mg7gENlGM=
X-Received: by 2002:adf:fb90:0:b0:2d6:9044:d836 with SMTP id
 a16-20020adffb90000000b002d69044d836mr2650840wrr.2.1680010695655; Tue, 28 Mar
 2023 06:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
 <ZCGFgypeuJXqNwQt@kroah.com> <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com>
 <ZCGONl0mC8oyBj-0@kroah.com> <CABVgOSnUCsxPf1mAL03GQzaw_kFtgf5J7aTPodo=j6O+wYZ2iQ@mail.gmail.com>
 <e9619a2a-b6c8-e7f9-6018-45541608d0c5@gmail.com>
In-Reply-To: <e9619a2a-b6c8-e7f9-6018-45541608d0c5@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 28 Mar 2023 21:38:03 +0800
Message-ID: <CABVgOS=Tb_VsfiQZ6hE62e0LqbpKczjLxitXrzBvmcuDPxfAZw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device creation
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c1714305f7f5f8e2"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--000000000000c1714305f7f5f8e2
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Mar 2023 at 21:22, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Hi David & Greg and thanks for working with this!
>
> On 3/28/23 15:45, David Gow wrote:
> > Thanks, Gred and Matti.
> >
> > On Mon, 27 Mar 2023 at 20:38, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Mon, Mar 27, 2023 at 03:20:06PM +0300, Matti Vaittinen wrote:
> >>> On 3/27/23 15:01, Greg Kroah-Hartman wrote:
> >>>> On Mon, Mar 27, 2023 at 02:34:02PM +0300, Matti Vaittinen wrote:
> >
> > I'm happy to keep working on this, but would definitely appreciate
> > your feedback.
> >
> > I've put my work-in-progress code here:
> > https://kunit.googlesource.com/linux/+/refs/heads/kunit/device-helpers%5E%21/#F0
> >
> > It creates a "kunit" bus, and adds a few helpers to create both
> > devices and drivers on that bus, and clean them up when the test
> > exits. It seems to work on all of the tests which used
> > root_device_register so far (except those -- only
> > test_iio_find_closest_gain_low so far -- which create multiple devices
> > with the same name, as the driver name won't be unique),
>
> I wouldn't worry about it for as long as it's just because an iio-gts
> test does something silly. Those tests are currently only in my personal
> playground and changing those tests should be pretty trivial.
>

Yeah: this isn't anything to worry about. It's as much my note as to
"what works with this code as-is", rather than indicative of a more
fundamental flaw.

> And right after saying that - the test_iio_find_closest_gain_low test does
>
> a) register a 'test' device
> b) perform test on devm_ API
> c) unregister the 'test' device
>
> d) register a 'test' device (same name as at step a)
> e) perform test on devm_ API
> f) unregister the 'test' device
>
> My assumption is that the test device would be gone after step c)
> because there should be no references to it anywhere. Hence, I wonder
> why registering at step d) fails? (Or did I misunderstand something?)
>

This is because I'm now creating a struct device_driver as well as a
device, and it's not being cleaned up until the end of the test.

The two solutions here would be to either:
- Add a way to clean up the driver earlier. (Shouldn't be too hard, I
just haven't got around to it yet), or:
- Use the same struct device_driver for both tests (there's a new
kunit_device_register_with_driver which allows you to pass a custom
driver in, rather than creating your own)

I think the latter's probably better, but I'll probably implement both
as I clean up the API further.

> > and the drm
> > tests work fine when ported to it as well.
> >
> > There's still a lot of cleanup to do and questions which need
> > answering, including:
> > - Working out how best to provide an owning module (it's currently
> > just kunit, but probably should be the module which contains the
> > actual tests)
>
> Maybe there is something I am not seeing but how about wrapping the
> kunit_device_register() in a macro and getting the THIS_MODULE in
> caller's context?
>

Yeah: that's probably what I'll do. The other possibility is to store
the module pointer in the struct kunit context.

> > In any case, does this seem like the right way forward?
>
> I am by no means an expert on this but this does look good to me. I
> would keep this as clean, lean and simple as possible in order to keep
> understanding / debugging the problems exposed by the tests as simple as
> possible. At some point someone is wondering why a test fails, and ends
> up looking through these helpers to ensure problem is no lurking
> there... Hence, I'd kept the code there in minimum - meaning, I might
> not add kunit class or even a driver until tests require that. (Even if
> it would not look as good in the sysfs - as far as I understand the
> kunit sysfs entries are a 'test feature' which should not be present in
> 'production systems'. This is not an excuse to make things bad - but (in
> my opinion) this is a good reason to prioritize simplicity.

I agree with you that it's best to avoid complexity for as long as we
reasonably can. I think that there are enough things which would
benefit from having the driver stuff to make it worth having
_something_ there, particularly since it makes this a more "normal"
device, so hopefully will be less surprising.

For sysfs, it's one of those things which shows up pretty rarely in
day-to-day KUnit use, as most people are using the kunit.py script
which has all of the tests built-in, and no userspace to look at sysfs
from. That being said, that doesn't cover all use cases, and I
definitely would rather not make sysfs unusably ugly for everyone
else, so I'm happy to tidy it up. (I'm not planning to do a kunit
class at the moment, though.)

I _think_ this approach (once the details of the API and
implementation are tidied up a bit) should sit in about the sweet spot
for complexity, assuming there's nothing horribly wrong with it I
haven't noticed. I suspect we're better off leaving some of the more
advanced use-cases to implement their own way of instantiating
devices, at least for now, and focus on getting these common cases
right.

Cheers,
-- David

--000000000000c1714305f7f5f8e2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD3
EFFRWrGwi0bJwxfUewt97EeUGLdC20UZ27plKAUFpjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjgxMzM4MTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAg2JZ4hgHrepDLqlVvs7M
OBcWCHWKJ7F044BH5oami78ttZdt1NSFvocvaF8+0PYPGexdJ4Z+LAeFLNNqXIgvG2qN8ediYYXY
G14Pzyk98wT3S6dmvUtGVhOfTaedm8e49rSAAJ1hqvQ3G3DYX4RdPyxG6wPqaTJTdNZu6KVFRNG4
gvc9W61jquMrFilzhvv/RmAjvXt4rNdjDrz95VH/XfDDQjQVXoTq5/Gf6JsOjeCE6hDKejgCyTAg
y1qTUhDWKG7cMCdWVu/s0xwllfKdnajUcWrrSRa6WsXag98Z5szDiBbbS2QXOBN/Zm1NpFEVu9Zg
XZG4fyR5KOiLQgBgJA==
--000000000000c1714305f7f5f8e2--
