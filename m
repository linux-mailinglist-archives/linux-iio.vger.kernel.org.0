Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77064BFA2
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLMWwE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 17:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLMWwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 17:52:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2111C129
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 14:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670971912; bh=vpcI92dRQpeDNOhYF9J1ffDnR5Zzo5SuHLtUTKJ0efc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=EbQxIbSMGZrR5BA0Q5CirPU8doj7MHH7K/JLsgN9Q/x40E8xSQZxJOn5Cg+Ea3kMR
         MLyee5jF0OD9JUmRkZZN0FVGXhh7lulF2txzdhk6A1rcsF7wd3P8IlgN2W69Y8rvas
         gyv+AMdAhEQH2dNmREeIc+gzWmmYAY+rrQgUf1836N8dbJXswzY/Kvjn53QjtuYBxl
         +X+5TnQYg75W5nlSPL75hXrVMlBEzfLFXWLxsqjaWBboATDlLJxU/pHiHiJq/qu2G9
         40NN5MaD564ROmdIn4Et+OtLao40Xwof2LJ+O9DyqbExvtbkdj8vDlJwJ4FjbdYvSV
         +AOUCVjAd718Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.87] ([95.223.44.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1pWHCk1GD4-00Qwru; Tue, 13
 Dec 2022 23:51:52 +0100
Message-ID: <cc35bdc25daedb32dbb5949f99559485a7f83080.camel@gmx.net>
Subject: Re: [PATCH v4 0/4] IIO: More HID custom sensors
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Tue, 13 Dec 2022 23:51:50 +0100
In-Reply-To: <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
         <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:k3ZrL/hyrlk4LkUqaVMyy7ZooFqSp1HSi6ryH6NMzNrr4e0d1Fy
 40nR7M0QcaTHNrZa3ybZymebNwSN2Qep7WVvcJ+CgoxmroOI3HKWDMzNEVyA92zJdxNex/o
 kNo10cfu+7uztWm6w6jzQVqoi5tFkhJJTNu6qvT8yxQ3uGpp5DKAwurNhRzJvYIuePkCnj9
 l4iR16xEBnlgVmk6wsg/w==
UI-OutboundReport: notjunk:1;M01:P0:QSO8+nwgbc4=;K+i/YZ7U+n9+wTzGM3XvJC1Aak6
 fYxbKsFEDTPPYid5c6/gF2EFjUnnoy+mv1i9UHt3/zAYbqXMFxEZ0N9RtDnp2HWJE+LHfoPNQ
 NmOvpO1dI2yF1fllAQ24wQPu7y9lQsoTSOqOUbFmimiu6tf4mFje8gP+JYTpkW7yPYMX+NAUu
 /o5pKLM34oiTuCZY3a3l557MdZU1YCcHFd5KSBKpVt15rKUn5YQ4hmqcDayiTmhaSp1u3bhOH
 NVQbpwZU+TLfqTOgVbuqVQ9jrYcj/QPV5lK5XEe9wV0otY3Focg02aUelhBEHTki2/yHmeXoO
 w9fm9QI4cQtT6D53bAljzpZE7AE9yqLdWS/FCmypaqn1kSfJ0F6c631eZxwp76KxIZgWpT+Po
 aGqNARQgKu735jkxDVFZ6txGcWgT9LPGRslFQIcR2y1Ywligv1Djdsn66J7VbVwz/4UaVAGmK
 oiFXGc/5Ot2E00LBC8d262jRanSUSmn5A2faYBjhBf5QfyWKHKB0Va5rNDBDE9PzKlxqQimGI
 Ow8zhHr63+n+hZn14b15URJJh4W3rVd5KIR6/dGqm5+U7cg5NChdV576Tktw3JVYeHbQAzdph
 0f6yrZ7KwkeHlxgk0odrZH9ZfsMWMSLSP3kgJyuEF05Tq/WwH+zvD/4rDXmAk7T+XbwFRBIHc
 4kSVRA8XmhK5ubgg7gKgI6bnICw7yn6UNcUCsN71RJTqh7iKUfmnHzH3Uvvjc1URZVEaOrOCc
 ilPmWd/VhUS12EC4zDacTfMiLxiBWb2sA/j3QKomg3KwzEb8nDTm4j9S3BXTDLMpTusmUdEyU
 oX/rWUcFe0VqTB5zWGBiIxpwAK5P22g3KWLVinM91l9LWQM8iirE5zfhvkLUPxVCLR8xLG4Kk
 RM02rQ7aXdwZ4aiQ9FIJwE54Vaypgv6s6O7kUDK/uq3Gb9iLvU3ucZFr6W8kfiplScpmNJheJ
 25le3b7hi/JcPSHWUHtg0UVfQtE=
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

Is there something I still need to do for this to be merged in the next
merge window?

I don't quite understand what would happen next. I'm curious and hope I
don't bother in the busy times when approaching a merge window.

Regards,
Philipp Jungkamp

On Sun, 2022-11-27 at 09:33 -0800, srinivas pandruvada wrote:
> On Fri, 2022-11-25 at 00:38 +0100, Philipp Jungkamp wrote:
> > Hello,
> >=20
> > I'm sorry for the confusion caused by me sending revisions as
> > replies.
> > I've now addresses the points raised. As I'm unfamiliar with
> > mailing
> > lists
> > any recommendation on making the process more seamless is welcome.
> >=20
> > Thank you for your time!
> >=20
>=20
> For the series
>=20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
>=20
> > v2:
> > - Patch 1/4:
> > =C2=A0 - Remove unnecessary comments.
> > =C2=A0 - Change return type of functions to bool. (introduced an error,
> > fixed in v4)
> > =C2=A0 - Swallows return value of a function. (fixed in v4)
> > - Patch 2/4:
> > =C2=A0 - Create this 'noop' patch that just adds the LISS sensors to th=
e
> > custom
> > =C2=A0=C2=A0=C2=A0 sensor match table.
> > - Patch 3/4:
> > =C2=A0 - Remove some unnecessary newlines in function calls.
> > - Patch 4/4:
> > =C2=A0 - Allow for 1 byte human presence reports.
> >=20
> > v3:
> > - Patch 2/4
> > =C2=A0 - Add missing 'Signed-Off-By'
> >=20
> > v4:
> > - Patch 1/4:
> > =C2=A0 - Fix return value and error codes on property query.
> > =C2=A0 - Document and ignore return values for queries of optionally
> > matched
> > =C2=A0=C2=A0=C2=A0 properties.
> > =C2=A0 - Don't modify *known in _get_known, return error when not
> > matched.
> > =C2=A0 - Remove comment on newly added sensors from commit message.
> > - Patch 4/4:
> > =C2=A0 - Clean up switch statement.
> >=20
> > Regards,
> > Philipp Jungkamp
> >=20
> > Philipp Jungkamp (4):
> > =C2=A0 HID: hid-sensor-custom: Allow more custom iio sensors
> > =C2=A0 HID: hid-sensor-custom: Add LISS custom sensors
> > =C2=A0 IIO: hid-sensor-als: Use generic usage
> > =C2=A0 IIO: hid-sensor-prox: Use generic usage
> >=20
> > =C2=A0drivers/hid/hid-sensor-custom.c=C2=A0=C2=A0=C2=A0=C2=A0 | 233 +++=
++++++++++++++++-----
> > ----
> > =C2=A0drivers/iio/light/hid-sensor-als.c=C2=A0 |=C2=A0 27 ++--
> > =C2=A0drivers/iio/light/hid-sensor-prox.c |=C2=A0 37 +++--
> > =C2=A0include/linux/hid-sensor-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > =C2=A04 files changed, 199 insertions(+), 99 deletions(-)
> >=20
> > --
> > 2.38.1
> >=20
>=20
>=20

