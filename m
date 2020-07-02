Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA32121F5
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jul 2020 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgGBLRL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jul 2020 07:17:11 -0400
Received: from sonic316-13.consmr.mail.bf2.yahoo.com ([74.6.130.123]:45822
        "EHLO sonic316-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbgGBLRK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jul 2020 07:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593688629; bh=NQQqU1PeFJSsC+ymHCz198coL/kqcVSY9gUcHqcpdis=; h=Date:From:Reply-To:Subject:References:From:Subject; b=d+SPetLPWDdjNO1S37zMWG5NExf6F3eAQS4OYISDoV5MHRYDKXYEAQD7YezAzc//UWA+hAV3EFe91JHr6IzaaIsfJ9SISYHXGvvGWdlYNnoTwl4D976Bvb4I4RT0sLTm3pceWBP2zYoHBDIt8ca3VfAyZAsJayN7D1JG5HFkd1e7xDAgIfUcofn3Lf24jSAh6+5auekcEYGSZRylETY8GFbbe2Vs5dliFi0zbFlX/M0IeXXbWuLixYPk81ayEYZ7ONZBF42k2BaLcrEh/U+yZx+wN6iYzGJi4vMSaMBXbgE4BbQtSc7IXmLcfEMCIi7BCNlLb4fD/vyK5Sn+S4ikCg==
X-YMail-OSG: 6lqJBoYVM1kaHDT7v0u7obhcJ9_o1lNJgmQtH.nl7IoTJa2f1GNSisAWcyTXU9i
 zNlAmUhCzDDSAC9K4qXxReJ.egbKeQ02mDK4h1FU7JakpYbaurj7J6CLDuTgJ78EBt9n8Acm0uxy
 kAL5..By61M6aD2oi4rjhvdOtzUmMtg0ePmWz4n4IxCPs6H90BvLqSlz0hsisUBMJHb4G_biu4RY
 PhzKYEstPvuvbPXz4h.Bn7kiMBBKP6Np3U6GfIe1uY0erO5LXahf_1R4A4blb8tAsvo9aU6h8Pbu
 qSIybBXV6XH14DEVKDY4vsMDCqhNSkSBxxgAHlkq0qHVPtZhSCTdSOLxzw6loLJMHUrIk_90eWJa
 Y4_sVGbJVk.YgAyIxSPeeAntOWWwh8cGJB9X7BeWHR1uqOAhuzbj6lWif_hYcsOM2tn5ZAH3J6es
 kJRjFDFZByauo6Y2khdvIMf2TaSvgV6mryxjhqBiynf__GsYwtDi0rb_qL0fuZG27S3qqKAbcjFx
 z74.XsKUQuZvuiFg2rf5BESVYO4IMV3V8CBmj7EXkqokff.g4evmOeB3n1e0nmmXan40LwY3jjix
 mrOgBxfbIMyK5A3LPCjdXwo8aHSwm8dIDe8SRfwWJrpDpWAauAHc_hMA1AeuIcyfpW7bMnnlKrV_
 erqOT2Dsuc3GaoNkRqQ8XSfNo0NopkQJ26DEeD7vwqmWQKn58CLyTBLXoOWtui4vbj.iMxFAbyMB
 qSrI8yijWWTOWVZD.L6e3p9mjaoB2C8ASoG.3ZUob89c7G3XIof5phzQOTz0ZY0Q.nDS5.u3xPdF
 U1YFQkHyENf5XfclcBizGo72nmZAz1lTDrjW3T7vdhh6Lu6N25alfpGsjQM0nt7Pdxv6theMt.UJ
 pMoix8jovO8xCwTxV2N2Kjn1lwypQPJezzESN8PWkdO0DBo9ZBXNGjn7EsVgSFnt0gd7tUpiJ38o
 oQ4X7YRdRAOz3WppHTF2lTEHGcFQFAIlEl45Jz6og3gSghM9oPXDMoy7.TsrGYlEhNhxp4RtrdZC
 jVJS33TwiRseqfuOdlO5k.mPx9OIKLyYWftRJqtIihKhqxfaO8Q04WNWkU4CVP9yFBT1jj_x6fVr
 kHt7i38Fu2Y2pTp4X.lgLh_LBAe_2TSZcDhTSNi7JEcTPz6PEveI1GAljU0POk9XLDHPNMm3f.7u
 vxB8yGAs2epUHWVEJ82HlbtQ3OijchzjxHFRTww_NYNiObRIMwBxPfUeYoX_sPwrn7lAAjdSq567
 8QY6RbMRVecFl37WxOiFubM3ojjU700YkPuDNqWiZiQUz5KLLMR5lNmbCmYowGbi1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 2 Jul 2020 11:17:09 +0000
Date:   Thu, 2 Jul 2020 11:17:05 +0000 (UTC)
From:   Marilis Mannik <mariliis.manniik@gmail.com>
Reply-To: manniik.mariliis@gmail.com
Message-ID: <1351281970.158395.1593688625919@mail.yahoo.com>
Subject: Urgent From Hospital
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1351281970.158395.1593688625919.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Hello=C2=A0My=C2=A0Beloved
this=C2=A0is=C2=A0Ms=C2=A0Marilis=C2=A0Mannik=C2=A0from=C2=A0Estonia=C2=A0w=
riting=C2=A0from=C2=A0the=C2=A0hospital=C2=A0here=C2=A0in=C2=A0Ivory=C2=A0C=
oast;Dear=C2=A0I=C2=A0want=C2=A0you=C2=A0to=C2=A0know=C2=A0that=C2=A0I'm=C2=
=A0dying=C2=A0here=C2=A0in=C2=A0this=C2=A0hospital=C2=A0right=C2=A0now=C2=
=A0which=C2=A0i=C2=A0don't=C2=A0know=C2=A0if=C2=A0i=C2=A0will=C2=A0see=C2=
=A0some=C2=A0few=C2=A0days=C2=A0to=C2=A0come.

My=C2=A0Beloved,=C2=A0i=C2=A0was=C2=A0informed=C2=A0by=C2=A0my=C2=A0doctor=
=C2=A0that=C2=A0i=C2=A0got=C2=A0poisoned=C2=A0and=C2=A0it=C2=A0affected=C2=
=A0my=C2=A0liver=C2=A0and=C2=A0i=C2=A0can=C2=A0only=C2=A0live=C2=A0for=C2=
=A0some=C2=A0days.=C2=A0The=C2=A0reason=C2=A0why=C2=A0i=C2=A0contacted=C2=
=A0you=C2=A0today=C2=A0is=C2=A0because=C2=A0i=C2=A0know=C2=A0that=C2=A0my=
=C2=A0step=C2=A0mother=C2=A0wanted=C2=A0to=C2=A0kill=C2=A0me=C2=A0and=C2=A0=
take=C2=A0my=C2=A0inheritance=C2=A0from=C2=A0my=C2=A0late=C2=A0Father.=C2=
=A0I=C2=A0have=C2=A0a=C2=A0little=C2=A0adopted=C2=A0child=C2=A0named=C2=A0A=
ndrew=C2=A0C.=C2=A0Mannik=C2=A0that=C2=A0i=C2=A0adopted=C2=A0in=C2=A0this=
=C2=A0Country=C2=A0when=C2=A0my=C2=A0late=C2=A0Father=C2=A0was=C2=A0alive=
=C2=A0and=C2=A0$3.5=C2=A0million=C2=A0Dollars=C2=A0i=C2=A0inherited=C2=A0fr=
om=C2=A0my=C2=A0late=C2=A0father.=C2=A0My=C2=A0step=C2=A0mother=C2=A0and=C2=
=A0her=C2=A0children=C2=A0they=C2=A0are=C2=A0after=C2=A0Andrew=C2=A0right=
=C2=A0now=C2=A0because=C2=A0they=C2=A0found=C2=A0out=C2=A0that=C2=A0Andrew=
=C2=A0was=C2=A0aware=C2=A0of=C2=A0the=C2=A0poison,=C2=A0and=C2=A0because=C2=
=A0i=C2=A0handed=C2=A0the=C2=A0documents=C2=A0of=C2=A0the=C2=A0fund=C2=A0ov=
er=C2=A0to=C2=A0him=C2=A0the=C2=A0day=C2=A0my=C2=A0step=C2=A0Mother=C2=A0po=
isoned=C2=A0my=C2=A0food,=C2=A0for=C2=A0that=C2=A0reason=C2=A0they=C2=A0do=
=C2=A0not=C2=A0want=C2=A0Andrew=C2=A0to=C2=A0expose=C2=A0them,=C2=A0so=C2=
=A0they=C2=A0are=C2=A0doing=C2=A0everything=C2=A0possible=C2=A0to=C2=A0kill=
=C2=A0him.

My=C2=A0Beloved,=C2=A0please=C2=A0i=C2=A0want=C2=A0you=C2=A0to=C2=A0help=C2=
=A0him=C2=A0out=C2=A0of=C2=A0this=C2=A0country=C2=A0with=C2=A0the=C2=A0mone=
y,=C2=A0he=C2=A0is=C2=A0the=C2=A0only=C2=A0one=C2=A0taking=C2=A0good=C2=A0c=
are=C2=A0of=C2=A0me=C2=A0here=C2=A0in=C2=A0this=C2=A0hospital=C2=A0right=C2=
=A0now=C2=A0and=C2=A0even=C2=A0this=C2=A0email=C2=A0you=C2=A0are=C2=A0readi=
ng=C2=A0now=C2=A0he=C2=A0is=C2=A0the=C2=A0one=C2=A0helping=C2=A0me=C2=A0out=
.=C2=A0I=C2=A0want=C2=A0you=C2=A0to=C2=A0get=C2=A0back=C2=A0to=C2=A0me=C2=
=A0so=C2=A0that=C2=A0he=C2=A0will=C2=A0give=C2=A0you=C2=A0the=C2=A0document=
s=C2=A0of=C2=A0the=C2=A0fund=C2=A0and=C2=A0he=C2=A0will=C2=A0direct=C2=A0yo=
u=C2=A0to=C2=A0a=C2=A0well=C2=A0known=C2=A0lawyer=C2=A0that=C2=A0i=C2=A0hav=
e=C2=A0appointed,=C2=A0the=C2=A0lawyer=C2=A0will=C2=A0assist=C2=A0you=C2=A0=
to=C2=A0change=C2=A0the=C2=A0documents=C2=A0of=C2=A0the=C2=A0fund=C2=A0to=
=C2=A0your=C2=A0name=C2=A0to=C2=A0enable=C2=A0the=C2=A0bank=C2=A0transfer=
=C2=A0the=C2=A0money=C2=A0to=C2=A0you..

This=C2=A0is=C2=A0the=C2=A0favor=C2=A0i=C2=A0need=C2=A0when=C2=A0you=C2=A0h=
ave=C2=A0gotten=C2=A0the=C2=A0fund:

(1)=C2=A0Keep=C2=A030%=C2=A0of=C2=A0the=C2=A0money=C2=A0for=C2=A0Andrew=C2=
=A0until=C2=A0he=C2=A0finish=C2=A0his=C2=A0studies=C2=A0to=C2=A0become=C2=
=A0a=C2=A0man=C2=A0as=C2=A0he=C2=A0has=C2=A0been=C2=A0there=C2=A0for=C2=A0m=
e=C2=A0as=C2=A0my=C2=A0lovely=C2=A0Son=C2=A0and=C2=A0i=C2=A0promised=C2=A0t=
o=C2=A0support=C2=A0him=C2=A0in=C2=A0life=C2=A0to=C2=A0become=C2=A0a=C2=A0m=
edical=C2=A0Doctor=C2=A0because=C2=A0he=C2=A0always=C2=A0desire=C2=A0for=C2=
=A0it=C2=A0with=C2=A0the=C2=A0scholarship=C2=A0he=C2=A0had=C2=A0won=C2=A0so=
=C2=A0far.=C2=A0I=C2=A0want=C2=A0you=C2=A0to=C2=A0take=C2=A0him=C2=A0along=
=C2=A0with=C2=A0you=C2=A0to=C2=A0your=C2=A0country=C2=A0and=C2=A0establish=
=C2=A0him=C2=A0as=C2=A0your=C2=A0son.

(2)=C2=A0Give=C2=A020%=C2=A0of=C2=A0the=C2=A0money=C2=A0to=C2=A0handicap=C2=
=A0people=C2=A0and=C2=A0charity=C2=A0organization.=C2=A0The=C2=A0remaining=
=C2=A050%=C2=A0should=C2=A0be=C2=A0yours=C2=A0for=C2=A0your=C2=A0help=C2=A0=
to=C2=A0Andrew.

Note;=C2=A0This=C2=A0should=C2=A0be=C2=A0a=C2=A0code=C2=A0between=C2=A0you=
=C2=A0and=C2=A0my=C2=A0son=C2=A0Andrew=C2=A0in=C2=A0this=C2=A0transaction=
=C2=A0"Hospital"=C2=A0any=C2=A0mail=C2=A0from=C2=A0him,=C2=A0the=C2=A0Lawye=
r=C2=A0he=C2=A0will=C2=A0direct=C2=A0you=C2=A0to,=C2=A0without=C2=A0this=C2=
=A0code=C2=A0"Hospital"=C2=A0is=C2=A0not=C2=A0from=C2=A0the=C2=A0Andrew,=C2=
=A0the=C2=A0Lawyer=C2=A0or=C2=A0myself=C2=A0as=C2=A0i=C2=A0don't=C2=A0know=
=C2=A0what=C2=A0will=C2=A0happen=C2=A0to=C2=A0me=C2=A0in=C2=A0the=C2=A0next=
=C2=A0few=C2=A0hours.

Finally,=C2=A0write=C2=A0me=C2=A0back=C2=A0so=C2=A0that=C2=A0Andrew=C2=A0wi=
ll=C2=A0send=C2=A0you=C2=A0his=C2=A0pictures=C2=A0to=C2=A0be=C2=A0sure=C2=
=A0of=C2=A0whom=C2=A0you=C2=A0are=C2=A0dealing=C2=A0with.=C2=A0Andrew=C2=A0=
is=C2=A014years=C2=A0now,=C2=A0therefore=C2=A0guide=C2=A0him.=C2=A0And=C2=
=A0if=C2=A0i=C2=A0don't=C2=A0hear=C2=A0from=C2=A0you=C2=A0i=C2=A0will=C2=A0=
look=C2=A0for=C2=A0another=C2=A0person=C2=A0or=C2=A0any=C2=A0organization.

May=C2=A0Almighty=C2=A0God=C2=A0bless=C2=A0you=C2=A0and=C2=A0use=C2=A0you=
=C2=A0to=C2=A0accomplish=C2=A0my=C2=A0wish.=C2=A0Pray=C2=A0for=C2=A0me=C2=
=A0always.
Ms=C2=A0Marilis=C2=A0Mannik
