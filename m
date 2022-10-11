Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913235FB7C2
	for <lists+linux-iio@lfdr.de>; Tue, 11 Oct 2022 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJKPws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Oct 2022 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJKPwW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2022 11:52:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2117.outbound.protection.outlook.com [40.107.114.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2254765C;
        Tue, 11 Oct 2022 08:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwsgWICQivz8iPWqCVx+ahhREVWFEal4PjueXXezZn5PkAbVUYCGilKKEAGGNdb9NYWYKJtgXJzIsK8ZxF5cYHl78ifAp7MeuPKF3ZZQbeTB3pSsQwCXjGVPBzIWbBaUQ3NMWZSb781ciOcFVQvD2Guzx+rIpDNhITHP5lC9spR21Cf/LPacB0DVOJgesQpHLbg/3APqzyAq/U77rHcjcIX7KmEyPmOCNToOviVl0B7dDhIzob6nSx787B7U49V9s+zprH3FVqRz/XEOP2ntgzgfSaBc5H/LGliFdBYw1Oa4bM/NIedqE+ZuuA2fBFrNuZQ/Pxzxx/F9GyKz05nlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qatqECsInZu0PqTA3rV8c9Lvjx3OrAlGiN3AcD1B9lQ=;
 b=FN6mcIF1443e72OfsUaZYw4NZ3V+l2IV+DbdOsUZirwh6KV7ipxZxKecbP+MBNJwimpdhCsEjLBgaBb5xqK1jStPJBlE9VxTv4NYRH1FM/tRAlEahFHRz0Ci/V+0KmnCis3pMA/mPQKWKbyPYKkkfZKwcZFSLM/4BUYj3JcMSknFNcUWpIbE5BQSgkWBiikSpRTABdn36R+WQUHEbXycVin7cTcRHqaSDCn3E0UKR9JsTQro0XWYamVSMtcBgEhMOowNT23HaO+6wfaT0Xc35+7ZXMGClkDDjLv234GcDhr65XhyODA9vg+dOeGkF7y9ANLlf9InTOX8d2kLd2+6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qatqECsInZu0PqTA3rV8c9Lvjx3OrAlGiN3AcD1B9lQ=;
 b=wr64njXJVHp3CotWz9o016d4ze440isIVhwljayId/NsBZ1YaOr+cfqWyJUs8aKdbrwXsl2dlod0hIBmI6l63JiMrVm4lG5J/2Do710G95fktu8H0XiB8STu0f937+McLsdmVIB9ih/aV9D9TtzwGH2LPyTIwd8h5Q+lME8LCMo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6308.jpnprd01.prod.outlook.com (2603:1096:604:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 15:50:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 15:50:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY2YuZOjF5ExCDW0e8KGUbGYk53a4DudqAgABULJCABSXXgIAAHhvw
Date:   Tue, 11 Oct 2022 15:50:38 +0000
Message-ID: <OS0PR01MB592280D15AF243C0A5FA93CD86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
 <Y0DUQTMd2TpFTnZS@fedora>
 <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0VsWdrpoAhM2jK3@fedora>
In-Reply-To: <Y0VsWdrpoAhM2jK3@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6308:EE_
x-ms-office365-filtering-correlation-id: 0829141c-89dd-47e8-a18d-08daaba0580f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36dxvzdXnzlDp0phLtsoUxifJB8byVdJxb6046q9sKBD+o6Qh8KO+VG+NcVceTf7GDNo6nN4+TxbROJqVzZMFw4RNLbEFRP516OsRGYuNu82/qMd9oOu+8bZVDkUcsBXccRH8Pay70wBcwECtufV9Gbosfuq9Qjpxt90jov6esmHZ79KIKulocP6i/R0fv0z4WlrIDPVJu4KNSaVdWa+LKeDmwbrNj6xU6SFcJwxaLCqvbeEViLURQWhKV1YUf003SXmljNmXT7mAkEej/WGbbMihMeErF8NcwKay7R5EhAx4XVHtOOWQhIZHW/ZwDRXHPnvY1AlSbuiYQqD/IWUUIGYHc3b9awQCr/NbXjG9HAbJROVt+BRPC+/zYoEkyk4mtoy6wizqvp5ArjPVvxBo7v4aOmu2Ak/jSGhubsIa8uJksbsmCExuMzUkjZvxihXwm6iMWUbhekRDUu0jA6dFTilD/0s1L46f6Dj2wLG0MyBqIJKLYU3ydsvDNQFf69ewHOhi7noMkN9O9KqYtI96OtYzLUY+rMbu+O/D2fwgmSDv985yUqA3IfRmSMPGzbu0+xqkMkaP9wKbtIel8N+wSYQKQXHjtDNwTkxEED2KgV4d5XAWsz73PXGT6UIAe7u7sSzrk0DdatCa6GVujrBgtaEY9pvVBVfR1Dcv+pt0zbIP7Y3wUf7efQL0wwNB8Dge/g8CF/YvqKJeZ6UhKNy7rHJmmd6nDpiKtpbWy7/nhoWWeVMq1V768gZlGYveyPfmaCsAqgjJh56D/gPB6SiHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(38100700002)(83380400001)(316002)(33656002)(9686003)(7696005)(6506007)(41300700001)(5660300002)(26005)(52536014)(8936002)(86362001)(66476007)(8676002)(66946007)(64756008)(66446008)(122000001)(76116006)(66556008)(4326008)(55016003)(6916009)(38070700005)(71200400001)(186003)(478600001)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GNWauDl5NRzV3N5lLLCLnlwIK0hVw/GDWZvGdQ5Kj+QSyGv9nlTFXmV97CH3?=
 =?us-ascii?Q?msaaANoz2AWQ3FtRVgjQAnjSqJZi+UQ5qzwnDnf9i0jN0SLiXarC8gyQHYgj?=
 =?us-ascii?Q?ahkRuI7ZYd2BJX+AWlwmAhTx3yEPXrI9rNcQrIfshCzOUHdNIIZ8+cWcTSys?=
 =?us-ascii?Q?swI2b3rCkr4pJYFL8dp6UxpWwRcG+2SoZGxXCHJZ4184UQNaeDpdrkTn3M7h?=
 =?us-ascii?Q?kUTX7vBWf1hxtiwbCW6PYZ0y9KD/o8eK0eJ33oIpwk7WBdDhHqWN6ynYI3ja?=
 =?us-ascii?Q?d01GeP8eAUnv9LFXktiVAh1G/DqySF9/Fi/5tSCJcmh1/yvQkOx5yjLLgBRL?=
 =?us-ascii?Q?bESkTzGU7cbCp0bKzvL7W3Q/biaA0N69wImMvgrjb6txUAYJCIqMbeRNarZg?=
 =?us-ascii?Q?7HoBQX+pFTTyWJhr2bw9gdPlkv1KA9ZQ4lTLsdaeMunLENFiWyhXb1T5Q3TM?=
 =?us-ascii?Q?u0nPAUiaS68ad5ESgRx+6PZZLdIUH19YxHkCk6f2+KjMdHbRPHUv4d+6/HfC?=
 =?us-ascii?Q?8WZxezcupUXMf//dlebHo7xN0KMYxqbSqwRu6amLdTkZS5qKvuo2hbrR7xQG?=
 =?us-ascii?Q?5LHblMKXQuxtjH8c/pCnOoyw0UuLN9Moso6o/2ZkaR+2noQEG5Hta+exQ1a+?=
 =?us-ascii?Q?5ybyKTII4gZrVCYFvifeIqNNjPmCYKthaFIrBXnr1J5K7CjZ4y19G0F+g9++?=
 =?us-ascii?Q?lKd5EfIfl+4BF9BvyGRc4FneZhQy3UG/5byW+7MaTz0sh4cnLuSvP5j+gK5S?=
 =?us-ascii?Q?5GHy1X+M4Y215hQlovIknENYERT4342m7Ddo+E+A5S40oYpv29wCxHn61N0L?=
 =?us-ascii?Q?hht8Pb0sVF0m0fb535uPcWMfBqVrkB+PP8ZuVNF3n4HCJjMwOwBFvs8Ufc22?=
 =?us-ascii?Q?v9xBvJkqEPFZadeUr3dAL5bf68ECp4/Z7ZQ8w//hGkGbugaczT0a4VJe4B0u?=
 =?us-ascii?Q?Zwt/4kMWtfC3OXkozzTxtlQ6SZ9Mxcs/f3A233Bb/5Vog1VdVvfNt5prfK0n?=
 =?us-ascii?Q?vjO0uhXebEkvOUneX+qcnaW/cxyFvdtd2iJMgzAVU6tpO1q53LeQXEpGsUkC?=
 =?us-ascii?Q?ukqP3N1291w7t8AgxiUDEayq8O8ZvhZxUnIJ+LRQzP9CYmdEYzq/dCfdXo5f?=
 =?us-ascii?Q?NFD0rY/dJNWuFTWzUsIKRLW9wsR6Wt+EpTFKKqfHczA5yy6gDZKCCvVTaF/Q?=
 =?us-ascii?Q?Ud2yMPt4JRPHJAXNQkPG1vcqvfAvxlEUZI8NGP1EfsERUirNcNiv/ycAS6SY?=
 =?us-ascii?Q?ZymE6hhBNOjrcTlkJrvb9Sf0NHKBAbE4OvpljRUBuOOQA0OS3PB1TG5+Q/2E?=
 =?us-ascii?Q?FzizKfwZGselUQFk4x/dYYKsGwwEZuCJt8F2bWY1CxbZgOhD05dkjzeoxNfv?=
 =?us-ascii?Q?HQHvySOyyOmaSwB72c3xYdaIdVjdGy7hcrIy6R2a36M0zLGeAuEJaEkdN4zv?=
 =?us-ascii?Q?Mms2+KLbBCe3Crl7TZtRaHryAze44tr/1iavwMGh2cwO2VkZ42Fadb4k2mey?=
 =?us-ascii?Q?LH2jZo3YjTsaCB+Op4PcJn9HSo5XimPf1Neuppv+3vJxn+KCwVfw/h1ECcxr?=
 =?us-ascii?Q?EKbozmDJ5b+SXoDmGqIH8UxxJag0KGmUyAtPkmQNz+nrxpYjp9EoeXhf7GoY?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0829141c-89dd-47e8-a18d-08daaba0580f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 15:50:38.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtD+/O4r6Y02coDPs2gBuw0A9wP2k4fSSJZ1WTBqIRjxKyfMHPMp7cEOSJPeuY59AHVEMlNPnl7NpCwdLFD+9eEk04997O05sjPRYxS/0Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6308
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
>=20
> On Sat, Oct 08, 2022 at 09:01:21AM +0000, Biju Das wrote:
> > Hi William Breathitt Gray,
> >
> > Thanks for the feedback.
>=20
> Hello Biju,
>=20
> I see that you have already released a v4, so some of my comments may
> no longer apply, but I want to respond here to continue our
> discussions; I'll reiterate any relevant suggestions when I review v4
> in the coming days.
>=20
> By the way, if you agree with a review comment there is no need to
> reply with "OK"; just delete the parts you agree with from your
> response and I'll know those are okay. Doing this will reduce the
> amount of text we have to scroll through and thus allow us to focus on
> just the questions we have remaining. ;-)

OK.

> > > Looks like something different is done when ceiling is set to 0.
> > > Would you explain what's happening in this case and why it's
> > > different that then else case below; in other words, what's the
> > > difference between RZ_MTU3_TCR_CCLR_NONE and
> RZ_MTU3_TCR_CCLR_TGRA?
> >
> > RZ_MTU3_TCR_CCLR_TGRA --> for triggering counter count using Z-Phase
> signal.
> > RZ_MTU3_TCR_CCLR_NONE --> No clearing.
>=20
> Does the Z-Phase signal trigger a reset of the counter count back to
> the ceiling value?=20

No, It resets to 0.

Does the count loop back to 0 when it passes the
> ceiling value,

Yes, it loopback to 0.

 or does it remain at the ceiling until the direction
> changes?

No.

> By "no clearing" do you mean that the ceiling is disabled in this case
> and the Counter count increases without limit?

Counter clear source disabled. So the counter won't reset to 0 by applying
Z-Phase signal.

>=20
> In the Counter subsystem, the "ceiling" Count extension puts an upper
> limit on the Count value. This means that setting "ceiling" to 0 would
> put the upper limit at 0, effectively restricting the Count value to 0
> until the value of "ceiling" is raised.
>=20
> If the device is unable to support a ceiling value of 0, you should
> return -ERANGE rather than disable the ceiling.

OK, will check this.


>=20
> > > > +static void rz_mtu3_16bit_cnt_setting(struct counter_device
> > > *counter,
> > > > +int id) {
> > > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > > +
> > > > +	priv->ch[id]->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
> > >
> > > If 16-bit phase counting is selected for one 16-bit counter, does
> > > the other 16-bit counter need to be configured as well?
> >
> > Not required I guess, as it is run time decision.
> >
> > After this, if user tries to enable 16-bit on other channel, we will
> > configure that channel. otherwise, we will return error, if user
> tries
> > to enable 32-bit channel.
> >
> > Are you ok with this?
>=20
> Because the phase mode affects how the device interprets multiple
> channels rather than a specific one, maybe it's better to save this
> state as an enum rz_mtu3_function member of struct rz_mtu3_cnt. Or if
> this is affecting the entire device, move it to your struct rz_mut3
> and share a pointer to that for your Counter and PWM drivers.

It is the same pointer allocated by parent and shared to both Counter
and PWM drivers. At runtime any device can claim the channel by checking
RZ_MTU3_NORMAL function.

>=20
> It makes me wonder if the rz_mut3_cnt structure is necessary for this
> Counter driver at all when you could pass a pointer your existing
> rz_mut3 structure instead in order to access the channels.

It is a shared pointer. For easy handling I have added=20
only 2 channels that are relevant for the counter in rz_mut3_cnt.
Similar case for pwm.

>=20
> > > > +	int ret =3D 0;
> > > > +
> > > > +	if (enable) {
> > > > +		pm_runtime_get_sync(ch->dev);
> > > > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> > >
> > > Are you using the Count's "enable" extension to switch between
> > > 16-bit and 32-bit phase modes?
> >
> > No. But will use that for switching on the next version.
>=20
> Sorry, I wasn't clear with my question. Please do not implement the
> "enable" Count extensions as a way to toggle between the 16-bit and
> 32-bit phase modes. The purpose of "enable" is to provide a
> pause/resume mechanism for a Count: the existing count value should be
> preserved when a Count is disabled, and should continue where it left
> off when the Count is enabled.

I use below sample program to test 16-bit and 32-bit phase mode
Counting with trigger for clear count by grounding the Z-phase pin.

16-bit phase testing
------------------
echo 1 > /sys/bus/counter/devices/counter0/count0/enable
echo 0 > /sys/bus/counter/devices/counter0/count0/count
echo 20 > /sys/bus/counter/devices/counter0/count0/ceiling
      =20
echo 1 > /sys/bus/counter/devices/counter0/count1/enable
echo 0 > /sys/bus/counter/devices/counter0/count1/count
echo 20 > /sys/bus/counter/devices/counter0/count1/ceiling

for i in {1..200};
do
   cat /sys/bus/counter/devices/counter0/count0/count;
   cat /sys/bus/counter/devices/counter0/count1/count;
done

echo 0 > /sys/bus/counter/devices/counter0/count1/enable
echo 0 > /sys/bus/counter/devices/counter0/count0/enable

32-bit phase count testing
--------------------------
echo 1 > /sys/bus/counter/devices/counter0/count2/enable
echo 0 > /sys/bus/counter/devices/counter0/count2/count
echo 20 > /sys/bus/counter/devices/counter0/count2/ceiling

for i in {1..200};
do
   cat /sys/bus/counter/devices/counter0/count2/count;
done

echo 0 > /sys/bus/counter/devices/counter0/count2/enable
=20
> To support the phase mode selection, implement a Counter device
> extension for that specific purpose. You can use DEFINE_COUNTER_ENUM()
> and COUNTER_COMP_DEVICE_ENUM() to create a device extension that will
> allow users to toggle between "16-bit" and "32-bit" phase modes. If
> you need help with these macros, just let me know.

Yes please, that will be helpful.=20

Cheers,
Biju
