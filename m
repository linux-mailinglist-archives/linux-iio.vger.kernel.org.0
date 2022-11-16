Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5346962BD52
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKPMRT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 07:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiKPMQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 07:16:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A9F4046B
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 04:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668600671; bh=ezXfI4GyJNoq6qFP5JAx1lmD4kL1bnvjLzdWNLHcHYo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=eUsasvmI4PzC1gUu4hS+h4xv2udEMVnZ5GtiY8OMua462BtC9/6dqLnwi5NazKcAy
         EZ2Vu/jk5j87DtQzHOrYEJvOQ2gqp06y2sq8hkzxYhpOI7HOxeK0fw/IX5QsXDyd7N
         TqDsSansGZjbNCCWuA4twHQwFgX27ul2BDvgDauIEdnEFhEZOSux7VLe3IG6zFKM4w
         Tdb5oOmK9hvX7iUN3+67ATc4dWOo8zCUYhmCUEGvMT6t72c8IhDWfEuklaNdagyIQH
         +7T/M15VD2yjEq5BO8s4YbtAeM7bNREfxOWhFxEZOnL4fRX1fipJm8ixbZ7zWvTrIZ
         IjtEXyeAujyoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.87] ([95.223.44.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1pR2AM3wz6-00h2Iu; Wed, 16
 Nov 2022 13:11:11 +0100
Message-ID: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
Subject: PROBLEM: Lenovo ALS sensor disguised under custom usage
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org
Date:   Wed, 16 Nov 2022 13:11:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:WypQbVkUix9EkzoJgNWXcxB3e36+1/EcuvdmZauzgrvDTK4oVSO
 aWWEpeE57L8xsCRuQ1VbkvRW1ZeQVUo4mkhpPEadygnYeKhEy0UatjrVPrxr20TYF39wE2B
 vbShKQK91tMC+Z2h7FPJrroI4nrjq+xtgHdOl5PFU+nqWVQ37zzIk9lOOd1BzXofmCQDY87
 N7XzJUmVN/QfdZqmmsmbw==
UI-OutboundReport: notjunk:1;M01:P0:dz2dQcwtgW8=;k6VY1GsJBAJ1HLMM7ES0WpQSnZr
 aP3zVMgJwCzv8T1aWIrXHvEUhT02/zVuCkTbGeMjyhzzgz25UZ2WbWNcJahpZSxFSBkZghb9R
 Wfwcx3bWk37fS5msfMrwNYykq5pEaQw4VyNHvs3PSxJnZPgtStA4QotK9PhVWYC1+AfjvQ+QG
 J4kDnthK8j6hQx1VDLNJmAzI8/HZjYXzzw9enP5n+YRabuauCQL0SIRSy4Xk1HaYa2OM1stU1
 OH7SJUa3Xr11inSX2Sc4f84Tsa0pA7CePYVxxHUwO1xqYKem5S/qQuRs53ckclOJYEJEqwbgS
 SP7y+lKI0WcGorx9JJSS2/C2i0KtsuUyIdahVO7Jo9bsu5KNlt2c40VQl6QLlqQXebMWvHUtX
 hZI6EQhQa3QttLCihubGGaptfRF5Nu8RYrLoEOHF2REZcRjwn+bWJsdwB86FB8hLWzqwri/D3
 GRT5DAMWfRpUXcQkL9i3/jX+82EKZyTW33IIRi5pQVJCpuInk2UeQZk9Gn/niLSArJ0VfNY/Y
 0/FT/x4X/OfaGETHXV+F5kRpPkTI5BgvB8ZBIb334cFTJ9QfNmx+BlqqdPf3MxglLc3nCi1zJ
 Pp6PO7N06QxjKpjZZRP/LWom3GhAIW0go4lYgMi1D5Cq5nwYkj1IDE0GwUVr1DXMLsUxEEoIJ
 +JCPOsG94Z2If1NVqzbstfiCPJt+hO8Xl8i78c3LTW94a4R9uxhUxwyW8Mij3dz+Y8z3a80+t
 OlB+yRG53U5LRKO2aNHO1dKA750W/IrgSUTcw9YcVtsmJFCX6tOlgWOffuvi2aA3qN6fEptpX
 3AOLBhTduwG6lO9KkedaQJXhepONhWONGDLtx/JX7uUUI+yS7H+7UGiPkrJGs6tOD1vBk8Lhz
 DJQ/X9Q96J9U0Xzd169XkpeEAYjdx0epoqKFrkMjKcYEzgYg+HZDluetsLRCEBOx1CV3+Af6T
 kJXZOlkbSC8w3NbyjcRkVMosSiw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

my Lenovo Yoga 9 14IAP7 includes several sensors above the screen which
are connected to the Intel ISH of this device. The report descriptor of
the sensor hub categorizes them in a custom usage. But fields under
that usage are clearly those of a sensor.

I went ahead and activated the sensor I believed to be for ambient
light sensing and checked the values reported. The sensor behaves like
a virtual ISH sensor. It does not report values on a synchronous
request. But, when in buffered mode, reports the light-level as
expected.

A modified version of hid-sensor-custom.c allowed for other known
sensors beside the intel-custom-hinge-sensor and exposed it under a
modified name as an hid sensor. I slightly modified the
hid-sensor-als.c to allow it to bind to this device and it works
without problems.

But, maybe a little late, I'm considering whether a fixup for the ish
report descriptor would be the better way to go.

I'll post the patches I used in reply to this message for discussion.
And I'd really like to see at least the ambient light sensor working on
mainline as an iio-sensor.

Lenovo seems to use the sensors for some proprietary features of their
Lenovo Vantage application under the name Lenovo Intelligent Sensing
Solution.

Regards,
Philipp Jungkamp


I used this fish script to query some information on the sensors:
https://raw.githubusercontent.com/PJungkamp/yoga9-linux/main/intel-ish/find=
_sensors.fish

Which yields this output on my device:
https://raw.githubusercontent.com/PJungkamp/yoga9-linux/main/intel-ish/sens=
ors.txt

Here is the report descriptor for the relevant ISH device (already
decoded text file):
https://raw.githubusercontent.com/PJungkamp/yoga9-linux/main/intel-ish/ish_=
report_descriptor



